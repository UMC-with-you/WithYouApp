//
//  LoginViewController.swift
//  WithYou
//
//  Created by 이승진 on 2024/01/26.
//  Copyright © 2024 withyou.org. All rights reserved.
//

import Alamofire
import UIKit
import SnapKit
import KakaoSDKCommon
import KakaoSDKAuth
import KakaoSDKUser

class LoginViewController: UIViewController {

    let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "MainLogo")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let appleLoginButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "AppleLogin"), for: .normal)
        button.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        return button
    }()
    
    let googleLoginButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "GoogleLogin"), for: .normal)
        button.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        return button
    }()
    
    let kakaoLoginButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "KakaoLogin"), for: .normal)
        button.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
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
    
    @objc private func loginButtonTapped() {
        UserApi.shared.loginWithKakaoAccount {(oauthToken, error) in
                if let error = error {
                    print(error)
                }
                else {
                    print("loginWithKakaoAccount() success.")
                    //do something
                    _ = oauthToken
                    print(oauthToken?.accessToken)
                    
                    let parameter = [
                        "accessToken" : oauthToken?.accessToken ?? "error",
                        "provider" : "kakao"
                    ]
                    
                    AF.request("http://54.150.234.75:8080/api/v1/auth/kakao", method: .post, parameters: parameter, encoding: JSONEncoding.default).responseDecodable(of: kakaoResponse.self){ response in
                        switch response.result{
                        case .success(let kakao):
                            print(kakao)
                        case .failure(let error):
                            print(error)
                        }
                    }
                }
            }
        /*
        let nickNameViewController = NickNameViewController()
               navigationController?.pushViewController(nickNameViewController, animated: true)
         */
    }
}



