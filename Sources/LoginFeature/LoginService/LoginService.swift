//
//  LoginService.swift
//  LoginFeature
//
//  Created by 김도경 on 7/8/24.
//  Copyright © 2024 withyou.org. All rights reserved.
//

import AuthenticationServices
import CryptoKit

import Foundation
//import GoogleSignIn
import KakaoSDKAuth
import KakaoSDKCommon
import KakaoSDKUser
import RxSwift

public final class LoginService : NSObject {
    
    private var currentNonce: String?
    private let authUseCase : AuthUseCase
    private var disposeBag = DisposeBag()
    
    public var window : UIWindow?
    
    public let loginResultSubject = PublishSubject<Bool>()
    
    public init(authUseCase : AuthUseCase){
        self.authUseCase = authUseCase
    }
    
    
    func login(with method: LoginMethod, _ googleCode: String = "") {
        switch method {
        case .kakao:
            loginWithKakao()
        case .google:
            loginWithGoogle(googleCode)
        case .apple:
            loginWithApple()
        }
    }
    
    func testApple() {
        self.loginWithApple()
    }
    
    private func loginWithKakao() {
            UserApi.shared.loginWithKakaoAccount {(oauthToken, error) in
                if let error = error {
                    print(error)
                } else {
                    print("loginWithKakaoAccount() success.")
                    guard let authCode = oauthToken else { return }
                    // 서버 통신
                    self.authUseCase.authWithKakao(authCode: authCode.accessToken)
                        .subscribe(onSuccess: { [weak self] _ in
                        self?.loginResultSubject.onNext(true)
                    })
                    .dispose()
                }
            }
    }
    
    private func loginWithGoogle(_ accessToken : String){
        self.authUseCase.authWithGoogle(authCode: accessToken).subscribe { result in
            self.loginResultSubject.onNext(true)
        }
        .disposed(by: disposeBag)
    }
    
    private func loginWithApple(){
        let nonce = randomNonceString()
        currentNonce = nonce
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]
        request.nonce = sha256(nonce)
        
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
    }
}


extension LoginService :ASAuthorizationControllerPresentationContextProviding , ASAuthorizationControllerDelegate{
    public func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.window!
    }
    // 성공 후 동작
    public func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization){
        //로그인 성공
        switch authorization.credential {
        case let appleIDCredential as ASAuthorizationAppleIDCredential:
            //처음 오는 Code 형태는 string이 아니라 변환해줘야함
            if let authorizationCode = appleIDCredential.authorizationCode,
                let identityToken = appleIDCredential.identityToken,
                let authCodeString = String(data: authorizationCode, encoding: .utf8),
                let identifyTokenString = String(data: identityToken, encoding: .utf8),
                let email = appleIDCredential.email,
                let userName = appleIDCredential.fullName,
                let nonce = currentNonce {
                
                authUseCase.authWithApple(accessToken: identifyTokenString, userName: userName.formatted(), email: email, nonce: nonce).subscribe { _ in
                    self.loginResultSubject.onNext(true)
                }
                .dispose()
            }
            //로그인 이후 로직
            
        case let passwordCredential as ASPasswordCredential:
            // Sign in using an existing iCloud Keychain credential.
            let username = passwordCredential.user
            let password = passwordCredential.password
            
            print("username: \(username)")
            print("password: \(password)")
            
        default:
            break
        }
    }
    
    // 실패 후 동작
    public func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print(error)
        print("apple login failed")
    }
    
    private func sha256(_ input: String) -> String {
        let inputData = Data(input.utf8)
        let hashedData = SHA256.hash(data: inputData)
        let hashString = hashedData.compactMap {
            return String(format: "%02x", $0)
        }.joined()
        
        return hashString
    }
    
    private func randomNonceString(length: Int = 32) -> String {
        precondition(length > 0)
        let charset: Array<Character> =
        Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")
        var result = ""
        var remainingLength = length
        
        while remainingLength > 0 {
            let randoms: [UInt8] = (0 ..< 16).map { _ in
                var random: UInt8 = 0
                let errorCode = SecRandomCopyBytes(kSecRandomDefault, 1, &random)
                if errorCode != errSecSuccess {
                    fatalError("Unable to generate nonce. SecRandomCopyBytes failed with OSStatus \(errorCode)")
                }
                return random
            }
            
            randoms.forEach { random in
                if remainingLength == 0 {
                    return
                }
                
                if random < charset.count {
                    result.append(charset[Int(random)])
                    remainingLength -= 1
                }
            }
        }
        return result
    }
}
