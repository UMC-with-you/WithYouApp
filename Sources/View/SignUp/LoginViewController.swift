//
//  LoginViewController.swift
//  WithYou
//
//  Created by 이승진 on 2024/01/26.
//  Copyright © 2024 withyou.org. All rights reserved.
//

import UIKit
import SnapKit

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
        let nickNameViewController = NickNameViewController()
               navigationController?.pushViewController(nickNameViewController, animated: true)
    }
}



