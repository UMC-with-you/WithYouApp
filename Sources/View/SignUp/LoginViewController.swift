//
//  LoginViewController.swift
//  WithYou
//
//  Created by 이승진 on 2024/01/26.
//  Copyright © 2024 withyou.org. All rights reserved.
//

import Alamofire
import AuthenticationServices
import GoogleSignIn
import KakaoSDKAuth
import KakaoSDKCommon
import KakaoSDKUser
import UIKit
import SnapKit




class LoginViewController: UIViewController {


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
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]
        
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
            }
            moveToMainView()
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
                    }
                    //로그인 이후 로직
                    self.moveToMainView()
                }
            }
    }
    
    func moveToMainView(){
        let VC = TabBarViewController()
        VC.modalPresentationStyle = .overFullScreen
        self.present(VC,animated: true)
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
                   let identifyTokenString = String(data: identityToken, encoding: .utf8) {
                   print("authorizationCode: \(authorizationCode)")
                   print("identityToken: \(identityToken)")
                   print("authCodeString: \(authCodeString)")
                   print("identifyTokenString: \(identifyTokenString)")
                   
                   AuthService.shared.authWithApple(authCodeString){ response in
                       print(response)
                       self.moveToMainView()
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
}
