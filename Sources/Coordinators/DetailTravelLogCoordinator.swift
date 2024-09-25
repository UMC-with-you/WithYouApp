//
//  DetailTravelLogCoordinator.swift
//  App
//
//  Created by bryan on 7/18/24.
//  Copyright © 2024 withyou.org. All rights reserved.
//


import Foundation
import UIKit

public final class DetailTravelLogCoordinator : Coordinator {
    
    public var childCoordinators: [Coordinator] = []
    public var parentCoordiantor: Coordinator?
    
    private var navigationController : UINavigationController
    
    private let log : Log
    
    public init(navigationController : UINavigationController, log : Log){
        self.navigationController = navigationController
        self.log = log
    }
    
    public func start() {
        let vm = DetailTravelViewModel(logUseCase: DefaultLogUseCase(repository: MockLogRepository()))
        let viewController = DetailTravelLogViewController(viewModel: vm, log: log)
        viewController.delegate = self
        self.navigationController.pushViewController(viewController, animated: true)
    }
}

extension DetailTravelLogCoordinator : DetailTravelViewDelegate {
    public func navigateToPostList() {
        let postCoordinator = PostCoordinator(navigationController: self.navigationController, log : self.log)
        postCoordinator.start()
        self.childCoordinators.append(postCoordinator)
    }
}
