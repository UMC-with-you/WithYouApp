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
        let viewModel : MainLogViewModel
        
        public init(navigationController: UINavigationController, viewModel: MainLogViewModel) {
            self.navigationController = navigationController
            self.viewModel = viewModel
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
        let viewController = MainViewController(viewModel: dependency.viewModel)
        navigationController.pushViewController(viewController, animated: true)
    }
}

