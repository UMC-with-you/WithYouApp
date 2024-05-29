//
//  LoginViewController.swift
//  WithYou
//
//  Created by 이승진 on 2024/01/26.
//  Copyright © 2024 withyou.org. All rights reserved.
//

import Alamofire
import AuthenticationServices
import CryptoKit
import Core
import Domain
import Foundation
//import GoogleSignIn
import KakaoSDKAuth
import KakaoSDKCommon
import KakaoSDKUser
import SnapKit
import RxCocoa
import RxSwift
import UIKit



public final class LoginViewController: BaseViewController {

    fileprivate var currentNonce: String?
    
    let viewModel : LoginViewModel
    
    public init(currentNonce: String? = nil, viewModel: LoginViewModel) {
        self.currentNonce = currentNonce
        self.viewModel = viewModel
        super.init()
    }
    
    lazy var loginView = LoginView()
    
    lazy var pages = BehaviorRelay(value: [
        CellData(mainText: "우리 여행의 한 페이지", subText: "Travel Log를 만들어\n함께 여행하는 사람들을 초대해보세요!", image: "MockUp"),
        CellData(mainText: "여행 전", subText: "Notice에서 중요한 사항들을 공유하고,\nPacking Togather에서 공동의 짐을 함께 챙겨요!", image: "MockUp1"),
        CellData(mainText: "오늘의 여행은 어떠셨나요?", subText: "하루가 끝나고\n오늘의 여행 Rewind를 통해 오늘의 여행을 기록하고\n오늘의 한마디를 전해주세요.", image: "MockUp2"),
        CellData(mainText: "여행이 끝난 후", subText: "Photo Book에서 우리만의 피드를 꾸미고\n Rewind Book으로 여행을 추억해요.\n공유 Cloud도 있어요!", image: "MockUp3")
    
    ])
    
    override public func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    public override func setFunc() {
        loginView.appleLoginButton
            .rx
            .tap
            .subscribe { [weak self] _ in
                self?.appleButtonTapped()
            }
            .disposed(by: disposeBag)
        
        loginView.kakaoLoginButton
            .rx
            .tap
            .subscribe { [weak self] _ in
                self?.kakaoButtonTapped()
            }
            .disposed(by: disposeBag)
    }
    
    public override func setUpViewProperty() {
        view.backgroundColor = UIColor(red: 0.969, green: 0.969, blue: 0.969, alpha: 1)
    }
    
    public override func setUp() {
        view.addSubview(loginView)
    }
    
    public override func setLayout() {
        loginView.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
    }
    
    @objc private func appleButtonTapped(){
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
    
    @objc private func googleButtonTapped(){
//        GIDSignIn.sharedInstance.signIn(withPresenting: self) { [weak self] signInResult, _ in
//            guard let self,
//                  let result = signInResult else { return }
//            // 서버에 토큰을 보내기
//            AuthService.shared.authWithGoogle(result.user.accessToken.tokenString){ response in
//                print(response)
//                //로그인 이후 로직
//                self.judgeNextStep(token: response)
//            }
//        }
    }
    
    @objc private func kakaoButtonTapped() {
        UserApi.shared.loginWithKakaoAccount {(oauthToken, error) in
                if let error = error {
                    print(error)
                }
                else {
                    print("loginWithKakaoAccount() success.")
                    //do something
                    guard let authCode = oauthToken else {return }
                    self.viewModel.kakaoLogin(authCode: authCode.accessToken)
                        .subscribe { token in
                            print(token)
                        } onFailure: { error in
                            print("error")
                        }
                        .disposed(by: self.disposeBag)

                }
            }
    }
    
    private func judgeNextStep(token: AuthToken){
        //토큰 저장
//        if self.saveTokens(tokens: token) {
////            if DataManager.shared.getIsLogin() {
////                //프로필이 존재하면 메인 화면으로 가기
////                let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate
////                guard let delegate = sceneDelegate else { return }
////                delegate.window?.rootViewController = TabBarViewController()
////            } else {
////                //첫 로그인 시 프로필 설정 화면으로 가기
////                
////                navigationController?.pushViewController(NickNameViewController(), animated: true)
////            }
//        } else {
//            print("토큰 저장 실패")
//        }
    }
}

extension LoginViewController :ASAuthorizationControllerPresentationContextProviding , ASAuthorizationControllerDelegate{
    public func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
    }
    // 성공 후 동작
    public func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization){
        //로그인 성공
        switch authorization.credential {
        case let appleIDCredential as ASAuthorizationAppleIDCredential:
            //처음 오는 Code 형태는 string이 아니라 변환해줘야함
            if  let authorizationCode = appleIDCredential.authorizationCode,
                let identityToken = appleIDCredential.identityToken,
                let authCodeString = String(data: authorizationCode, encoding: .utf8),
                let identifyTokenString = String(data: identityToken, encoding: .utf8),
                let email = appleIDCredential.email,
                let userName = appleIDCredential.fullName,
                let nonce = currentNonce{
                
                self.viewModel.appleLogin(accessToken: identifyTokenString, userName: userName.formatted(), email: email, provider: "apple" , nonce: nonce)
                    .subscribe { token in
                        print("good")
                    } onFailure: { error in
                        print(error)
                    }.disposed(by: disposeBag)

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
