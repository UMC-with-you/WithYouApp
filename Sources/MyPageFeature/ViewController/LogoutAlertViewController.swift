//
//  LogoutAlertViewController.swift
//  WithYou
//
//  Created by 배수호 on 6/22/25.
//  Copyright © 2025 WithYou.app. All rights reserved.
//

import UIKit
import SnapKit

final class LogoutAlertViewController: UIViewController {
    
    private let backgroundView = UIView()
    private let alertView = UIView()
    private let messageLabel = UILabel()
    
    lazy var logoutButton = {
        let button = WYButton("확인")
        button.backgroundColor = WithYouAsset.mainColorDark.color
        button.titleLabel?.font = WithYouFontFamily.Pretendard.semiBold.font(size: 16)
        button.layer.cornerRadius = 25
        return button
    }()
    
    lazy var cancelButton = {
        let button = WYButton("취소")
        button.backgroundColor = WithYouAsset.mainColorDark.color
        button.titleLabel?.font = WithYouFontFamily.Pretendard.semiBold.font(size: 16)
        button.layer.cornerRadius = 25
        return button
    }()
    
    var onLogoutConfirm: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupLayout()
    }
    
    private func setupUI() {
        view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        
        alertView.backgroundColor = .white
        alertView.layer.cornerRadius = 16
        
        messageLabel.text = "로그아웃 하시겠습니까?"
        messageLabel.font = WithYouFontFamily.Pretendard.semiBold.font(size: 20)
        messageLabel.textAlignment = .center
        messageLabel.numberOfLines = 0
        
        cancelButton.addTarget(self, action: #selector(cancelTapped), for: .touchUpInside)
        logoutButton.addTarget(self, action: #selector(logoutTapped), for: .touchUpInside)
        
        
        view.addSubview(alertView)
        alertView.addSubview(messageLabel)
        alertView.addSubview(cancelButton)
        alertView.addSubview(logoutButton)
    }
    
    private func setupLayout() {
        alertView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.equalTo(361)
            $0.height.equalTo(196)
        }
        
        messageLabel.snp.makeConstraints {
            $0.top.equalTo(alertView).offset(24)
            $0.leading.trailing.equalTo(alertView).inset(16)
        }
        
        cancelButton.snp.makeConstraints {
            $0.top.equalTo(messageLabel.snp.bottom).offset(20)
            $0.leading.equalTo(alertView).offset(20)
            $0.bottom.equalTo(alertView).offset(-17)
            $0.width.equalTo(150)
            $0.height.equalTo(52)
        }
        
        logoutButton.snp.makeConstraints {
            $0.top.equalTo(cancelButton)
            $0.trailing.equalTo(alertView).offset(-20)
            $0.bottom.equalTo(cancelButton)
            $0.width.equalTo(150)
            $0.height.equalTo(52)
        }
    }
    
    @objc private func cancelTapped() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func logoutTapped() {
        dismiss(animated: true) {
            self.onLogoutConfirm?()
        }
    }
}
