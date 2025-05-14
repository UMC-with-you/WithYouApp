//
//  UIViewController+extension.swift
//  WithYou
//
//  Created by 배수호 on 5/14/25.
//  Copyright © 2025 WithYou.app. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func setupBackButton() {
        navigationController?.navigationItem.backButtonTitle = ""
        
        let backButton = UIButton(configuration: {
            var config = UIButton.Configuration.plain()
            config.image = UIImage(systemName: "chevron.left")
            config.baseForegroundColor = WithYouAsset.logoColor.color
            config.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 0)
            return config
        }())

        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        let leftItem = UIBarButtonItem(customView: backButton)
        navigationItem.leftBarButtonItem = leftItem
    }

    
    @objc func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
}
