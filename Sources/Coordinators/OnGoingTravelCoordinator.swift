//
//  OnGoingTravelCoordinator.swift
//  WithYou
//
//  Created by bryan on 9/23/24.
//

import Foundation
import UIKit

final public class OnGoingTravelCoordinator : Coordinator {
    
    private var navigationController: UINavigationController
    
    public var childCoordinators: [Coordinator] = []
    public var parentCoordinator: Coordinator?
    
    private let log : Log
    
    public init(navigationController : UINavigationController, log : Log) {
        self.navigationController = navigationController
        self.log = log
    }
    
    public func start() {
        let useCase = DIContainer.shared.resolve(NoticeUseCase.self)!
        let viewModel = OnGoingTravelViewModel(log: self.log, noticeUseCase: useCase)
        let viewController = OnGoingTravelViewController(viewModel: viewModel)
        self.navigationController.pushViewController(viewController, animated: true)
        viewController.coordinator = self
    }
}

extension OnGoingTravelCoordinator : OnGoingTravelViewControllerDelgate {
    public func navigateToCreatRewind(log: Log) {
        let coordinator = CreateRewindCoordinator(navigationController: self.navigationController, log: self.log)
        coordinator.start()
    }
}
