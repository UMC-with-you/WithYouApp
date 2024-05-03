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
import GoogleSignIn
import KakaoSDKAuth
import KakaoSDKCommon
import KakaoSDKUser
import UIKit
import SnapKit



class LoginViewController: UIViewController {

    fileprivate var currentNonce: String?
    
    let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "MainLogo")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let appleLoginButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "AppleLogin"), for: .normal)
        button.addTarget(self, action: #selector(appleButtonTapped), for: .touchUpInside)
        return button
    }()
    
    let googleLoginButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "GoogleLogin"), for: .normal)
        button.addTarget(self, action: #selector(googleButtonTapped), for: .touchUpInside)
        return button
    }()
    
    let kakaoLoginButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "KakaoLogin"), for: .normal)
        button.addTarget(self, action: #selector(kakaoButtonTapped), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //        backgroundColor = .white
        view.backgroundColor = UIColor(red: 0.969, green: 0.969, blue: 0.969, alpha: 1)
        setViews()
        setConstraints()
    }
    
    private func setViews() {
        view.addSubview(logoImageView)
        view.addSubview(appleLoginButton)
        view.addSubview(googleLoginButton)
        view.addSubview(kakaoLoginButton)
    }
    
    private func setConstraints() {
        
        logoImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-20)
        }
        
        appleLoginButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(logoImageView.snp.bottom).offset(80)
            make.width.equalTo(360)
            make.height.equalTo(60)
        }
        
        googleLoginButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(appleLoginButton.snp.bottom).offset(10)
            make.width.equalTo(360)
            make.height.equalTo(60)
        }
        
        kakaoLoginButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(googleLoginButton.snp.bottom).offset(10)
            make.width.equalTo(360)
            make.height.equalTo(60)
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
        GIDSignIn.sharedInstance.signIn(withPresenting: self) { [weak self] signInResult, _ in
            guard let self,
                  let result = signInResult else { return }
            // 서버에 토큰을 보내기
            AuthService.shared.authWithGoogle(result.user.accessToken.tokenString){ response in
                print(response)
                //로그인 이후 로직
                self.judgeNextStep(token: response)
            }
        }
    }
    
    @objc private func kakaoButtonTapped() {
        UserApi.shared.loginWithKakaoAccount {(oauthToken, error) in
                if let error = error {
                    print(error)
                }
                else {
                    print("loginWithKakaoAccount() success.")
                    //do something
                    _ = oauthToken
                    AuthService.shared.authWithKakao(oauthToken?.accessToken ?? "error"){ response in
                        print(response)
                        self.judgeNextStep(token: response)
                    }
                }
            }
    }
    
    private func judgeNextStep(token: AuthModelResponse){
        //토큰 저장
        if self.saveTokens(tokens: token) {
            if DataManager.shared.getIsLogin() {
                //프로필이 존재하면 메인 화면으로 가기
                let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate
                guard let delegate = sceneDelegate else { return }
                delegate.window?.rootViewController = TabBarViewController()
    
            } else {
                //첫 로그인 시 프로필 설정 화면으로 가기
                
                navigationController?.pushViewController(NickNameViewController(), animated: true)
            }
        } else {
            print("토큰 저장 실패")
        }
    }
    
    private func moveToView(newVC: UIViewController){
        newVC.modalPresentationStyle = .overFullScreen
        self.present(newVC,animated: true)
    }


    func saveTokens(tokens: AuthModelResponse) -> Bool{
        if SecureDataManager.shared.setData(tokens.accessToken, label: .accessToken) && SecureDataManager.shared.setData(tokens.refreshToken, label: .refreshToken) {
            return true
        } else {
            return false
        }
    }
}

extension LoginViewController :ASAuthorizationControllerPresentationContextProviding , ASAuthorizationControllerDelegate{
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
    }
    // 성공 후 동작
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization){
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

                AuthService.shared.authWithApple(identifyTokenString, userName: userName.formatted(), email: email,nonce: nonce){ response in
                    print(response)
                    self.judgeNextStep(token: response)
                }
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
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
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
