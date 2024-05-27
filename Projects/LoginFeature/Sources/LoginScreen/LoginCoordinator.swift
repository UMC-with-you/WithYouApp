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
    public var childCoordinaotrs: [Coordinator] = []
    
    private var navigationController: UINavigationController!
    
    public init(navigationController : UINavigationController){
        self.navigationController = navigationController
    }
    
    public func start() {
        let viewController = OnBoardingViewController()
        navigationController.pushViewController(viewController, animated: true)
    }
}
