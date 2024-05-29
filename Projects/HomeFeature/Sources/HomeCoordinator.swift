//
//  HomeCoordinator.swift
//  HomeFeature
//
//  Created by 김도경 on 5/27/24.
//  Copyright © 2024 withyou.org. All rights reserved.
//

import Core
import Foundation
import UIKit

public final class HomeCoordinator : Coordinator {
    
    public struct Dependecy{
        let navigationController : UINavigationController
        let homeViewController : MainViewController
        
        public init(navigationController: UINavigationController, homeViewController: MainViewController) {
            self.navigationController = navigationController
            self.homeViewController = homeViewController
        }
    }
    
    public var childCoordinaotrs: [Coordinator] = []
    
    private let dependency : Dependecy
    
    private var navigationController: UINavigationController!
    
    public init(dependency : Dependecy){
        self.dependency = dependency
        self.navigationController = dependency.navigationController
    }
    
    public func start() {
        navigationController.pushViewController(dependency.homeViewController, animated: true)
    }
}

