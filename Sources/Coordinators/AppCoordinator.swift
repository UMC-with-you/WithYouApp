//
//  AppCoordinator.swift
//  App
//
//  Created by 김도경 on 5/26/24.
//  Copyright © 2024 withyou.org. All rights reserved.
//

import Foundation
import UIKit

class AppCoordinator : Coordinator {
    var childCoordinators: [Coordinator] = []
    var parentCoordiantor: Coordinator?
    
    private var navigationController : UINavigationController
   
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        // 만약 처음이라면 OnBoarding
        // OnBoarding을 했으면 Login
        // 로그인이 된 상태라면 로그인 진행
        if UserDefaultsManager.isLoggined {
            startTabbarScene()
        } else {
            startLoginScene()
        }
    }
    
    public func startTabbarScene(){
        let tabCoordinator = TabbarCoordinator(navigationController: navigationController)
        tabCoordinator.parentCoordiantor = self
        tabCoordinator.start()
        self.childCoordinators.append(tabCoordinator)
    }
    
    
    public func startLoginScene(){
        let loginCoordinator = LoginCoordinator(navigationController: self.navigationController)
        loginCoordinator.parentCoordiantor = self
        loginCoordinator.start()
        
        self.childCoordinators.append(loginCoordinator)
    }
}

