//
//  PostCoordinator.swift
//  App
//
//  Created by 김도경 on 7/17/24.
//  Copyright © 2024 withyou.org. All rights reserved.
//

import Core
import Data
import Domain
import Foundation
import TravelLogFeature
import UIKit

final public class PostCoordinator : Coordinator {
    
    public var childCoordinators: [Coordinator] = []
    public var parentCoordiantor: Coordinator?
    
    private var navigationController : UINavigationController
    
    private let log : Log
    
    public init(navigationController : UINavigationController, log : Log){
        self.navigationController = navigationController
        self.log = log
    }
    
    public func start() {
        let postRepository = MockPostRepository()
        let useCase = DefaultPostUseCase(repository: postRepository)
        let viewModel = PostListViewmodel(postUseCase: useCase, log: self.log)
        let viewController = PostListViewController(viewModel: viewModel)
        self.navigationController.pushViewController(viewController, animated: true)
    }
}
