//
//  ProfileSettingCoordinator.swift
//  WithYou
//
//  Created by 이승진 on 4/4/25.
//  Copyright © 2025 WithYou.app. All rights reserved.
//

import UIKit

final public class ProfileSettingCoordinator: Coordinator {
    public var childCoordinators: [Coordinator] = []
    public var parentCoordiantor: Coordinator?
    
    private let navigationController: UINavigationController
    
    public init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    public var nickName: String?
    
    public func start() {
        let nickVC = NickNameViewController()
        nickVC.coordinator = self
        navigationController.pushViewController(nickVC, animated: true)
    }

    public func navigateProfileSetVC(nickName: String) {
        self.nickName = nickName
        let profileSetVC = ProfileSetViewController()
        profileSetVC.nickName = nickName
        profileSetVC.coordinator = self
        navigationController.pushViewController(profileSetVC, animated: true)
    }

    public func navigateNameVC() {
        let nameVC = NameProfileViewController()
        nameVC.nickName = self.nickName
        nameVC.coordinator = self
        navigationController.pushViewController(nameVC, animated: true)
    }

    public func finishProfileSetting() {
        // tabbar로 이동
        let appCoordinator = self.parentCoordiantor as! AppCoordinator
        appCoordinator.startTabbarScene()
        appCoordinator.childDidFinish(self)
    }
}
