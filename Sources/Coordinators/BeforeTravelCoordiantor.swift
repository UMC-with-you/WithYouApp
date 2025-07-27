//
//  BeforeTravelCoordiantor.swift
//  App
//
//  Created by 김도경 on 6/11/24.
//  Copyright © 2024 withyou.org. All rights reserved.
//


import UIKit

final public class BeforeTravelCoordiantor : Coordinator {
    
    private var navigationController: UINavigationController
    
    public var childCoordinators: [Coordinator] = []
    public var parentCoordinator: Coordinator?
    
    private let log : Log
    
    public init(navigationController : UINavigationController, log : Log) {
        self.navigationController = navigationController
        self.log = log
    }
    
    public func start() {
        let logUseCase = DIContainer.shared.resolve(LogUseCase.self)!
        let packingUseCase = DIContainer.shared.resolve(PackingItemUseCase.self)!
        let noticeUseCase = DIContainer.shared.resolve(NoticeUseCase.self)!
        let beforeTravelViewModel = BeforeTravelLogViewModel(log: log, noticeUseCase: noticeUseCase, logUseCase: logUseCase, packingUseCase: packingUseCase)
        let beforeTravelViewController = BeforeTravelLogViewController(viewModel: beforeTravelViewModel)
        beforeTravelViewController.coordinator = self
        navigationController.pushViewController(beforeTravelViewController, animated: true)
    }
}

extension BeforeTravelCoordiantor {
    public func dismissView() {
        parentCoordinator?.childDidFinish(self)
    }
}

extension BeforeTravelCoordiantor : BeforeTravelLogViewControllerDelgate {
    
    public func openSideMenu(travelers : [Traveler]) {
        let sideBarCoordinator = BeforeTravelSideBarCoordinator(navigationController: navigationController, log: log, travelers: travelers)
        
        sideBarCoordinator.parentCoordinator = self
        childCoordinators.append(sideBarCoordinator)
        sideBarCoordinator.start()
    }
}
