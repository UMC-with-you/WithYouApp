//
//  PostCoordinator.swift
//  App
//
//  Created by 김도경 on 7/17/24.
//  Copyright © 2024 withyou.org. All rights reserved.
//

import Foundation
import UIKit

final public class PostCoordinator : Coordinator {
    
    public var childCoordinators: [Coordinator] = []
    public var parentCoordiantor: Coordinator?
    
    private var navigationController : UINavigationController
    
    private let log : Log
    
    final let postRepository : PostRepository
    final let useCase : PostUseCase
    
    public init(navigationController : UINavigationController, log : Log){
        self.navigationController = navigationController
        self.log = log
        self.postRepository = MockPostRepository()
        self.useCase = DefaultPostUseCase(repository: postRepository)
    }
    
    public func start() {
        let viewModel = PostListViewmodel(postUseCase: self.useCase, log: self.log)
        let viewController = PostListViewController(viewModel: viewModel)
        self.navigationController.pushViewController(viewController, animated: true)
        viewController.coordinator = self
    }
}

extension PostCoordinator : PostListViewControllerDelgate{
    func navigateToDetailPost(_ postId: Int) {
        let viewModel = PostDetailViewModel(postUseCase: self.useCase, postId: postId, log: self.log)
        let viewController = DetailPostViewController(viewModel: viewModel)
        self.navigationController.pushViewController(viewController, animated: true)
    }
}

