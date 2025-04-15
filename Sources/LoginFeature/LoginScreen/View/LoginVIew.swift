//
//  LoginVIew.swift
//  LoginFeature
//
//  Created by 김도경 on 5/26/24.
//  Copyright © 2024 withyou.org. All rights reserved.
//


import UIKit
import SnapKit

final class LoginView: BaseUIView {
    
    let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "MainLogo")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let appleLoginButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "AppleLogin"), for: .normal)
        return button
    }()
    
    let googleLoginButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "GoogleLogin"), for: .normal)
        return button
    }()
    
    let kakaoLoginButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "KakaoLogin"), for: .normal)
        return button
    }()
    
    override func initUI() {
        backgroundColor = UIColor(red: 0.969, green: 0.969, blue: 0.969, alpha: 1)
        
        addSubview(logoImageView)
        addSubview(appleLoginButton)
        addSubview(googleLoginButton)
        addSubview(kakaoLoginButton)
    }
    
    override func initLayout() {
        
        logoImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(CGFloat(294.57).adjustedH)
        }
        
        kakaoLoginButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(logoImageView.snp.bottom).offset(CGFloat(169).adjustedH)
            make.width.equalTo(CGFloat(300).adjusted)
            make.height.equalTo(CGFloat(45).adjustedH)
        }
        
        appleLoginButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(kakaoLoginButton.snp.bottom).offset(CGFloat(11).adjustedH)
            make.width.equalTo(CGFloat(300).adjusted)
            make.height.equalTo(CGFloat(45).adjustedH)
        }
        
        googleLoginButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(appleLoginButton.snp.bottom).offset(CGFloat(11).adjustedH)
            make.width.equalTo(CGFloat(300).adjusted)
            make.height.equalTo(CGFloat(45).adjustedH)
        }
    }
}
