//
//  BeforeTravelSideBarCoordinator.swift
//  App
//
//  Created by 김도경 on 6/17/24.
//  Copyright © 2024 withyou.org. All rights reserved.
//

import Foundation
import UIKit

final public class BeforeTravelSideBarCoordinator : Coordinator {
    
    private var navigationController: UINavigationController
    
    public var childCoordinators: [Coordinator] = []
    weak public var parentCoordiantor: Coordinator?
    
    private let log : Log
    private let travelers : [Traveler]
    
    public init(navigationController : UINavigationController, log : Log, travelers : [Traveler]) {
        self.navigationController = navigationController
        self.log = log
        self.travelers = travelers
    }
    
    public func start() {
        let logUseCase = DefaultLogUseCase(repository: MockLogRepository())
        let sideBarViewModel = BeforeTravelSideBarViewModel(logUseCase: logUseCase, travelers: travelers, log: log)
        let sideBarViewController = BeforeTravelSideBarViewController(viewModel: sideBarViewModel)
        
        sideBarViewController.modalPresentationStyle = .overFullScreen
        sideBarViewController.modalTransitionStyle = .crossDissolve
        sideBarViewController.coordinator = self
        self.navigationController.present(sideBarViewController, animated: true)
    }
}

extension BeforeTravelSideBarCoordinator : BeforeTravelSideBarDelegate{
    public func dissmissView(){
        parentCoordiantor?.childDidFinish(self)
        self.navigationController.dismiss(animated: true)
    }
    
    public func leaveLog(){
        self.dissmissView()
        self.navigationController.popToRootViewController(animated: true)
    }
}
