//
//  BeforeTravelCoordiantor.swift
//  App
//
//  Created by 김도경 on 6/11/24.
//  Copyright © 2024 withyou.org. All rights reserved.
//

import Core
import Data
import Domain
import Foundation
import HomeFeature
import UIKit

final public class BeforeTravelCoordiantor : Coordinator {
    
    private var navigationController: UINavigationController
    
    public var childCoordinators: [Coordinator] = []
    public var parentCoordiantor: Coordinator?
    
    private let log : Log
    
    public init(navigationController : UINavigationController, log : Log) {
        self.navigationController = navigationController
        self.log = log
    }
    
    public func start() {
        let logUseCase = DefaultLogUseCase(repository: MockLogRepository())
        let packingUseCase = DefaultPackingItemUseCase(repository: MockPackingRepository())
        let beforeTravelViewModel = BeforeTravelLogViewModel(log: log, noticeUseCase: DefaultNoticeUseCase(repository: MockNoticeRepository()), logUseCase: logUseCase, packingUseCase: packingUseCase)
        let beforeTravelViewController = BeforeTravelLogViewController(viewModel: beforeTravelViewModel)
        beforeTravelViewController.coordinator = self
        navigationController.pushViewController(beforeTravelViewController, animated: true)
    }
}

extension BeforeTravelCoordiantor {
    public func dismissView() {
        parentCoordiantor?.childDidFinish(self)
    }
}

extension BeforeTravelCoordiantor : BeforeTravelLogViewControllerDelgate {
    
    public func openSideMenu(travelers : [Traveler]) {
        let sideBarCoordinator = BeforeTravelSideBarCoordinator(navigationController: navigationController, log: log, travelers: travelers)
        
        sideBarCoordinator.parentCoordiantor = self
        childCoordinators.append(sideBarCoordinator)
        sideBarCoordinator.start()
    }
}
