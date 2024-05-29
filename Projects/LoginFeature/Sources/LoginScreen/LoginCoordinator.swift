//
//  LoginCoordinator.swift
//  LoginFeature
//
//  Created by 김도경 on 5/26/24.
//  Copyright © 2024 withyou.org. All rights reserved.
//

import Core
import Foundation
import UIKit

public class LoginCoordinator : Coordinator {
    
    public struct Dependecy{
        let loginViewController : LoginViewController
        let navigationController : UINavigationController
        
        public init(loginViewController: LoginViewController, navigationController: UINavigationController) {
            self.loginViewController = loginViewController
            self.navigationController = navigationController
        }
    }
    
    let dependency : Dependecy
    public var childCoordinaotrs: [Coordinator] = []
    private var navigationController: UINavigationController
    
    public init(dependency : Dependecy){
        self.dependency = dependency
        self.navigationController = dependency.navigationController
    }
    
    public func start() {
        navigationController.pushViewController(dependency.loginViewController, animated: true)
    }
}
