//
//  HomeCoordinator.swift
//  HomeFeature
//
//  Created by 김도경 on 5/27/24.
//  Copyright © 2024 withyou.org. All rights reserved.
//

import Foundation
import UIKit

public final class HomeCoordinator : Coordinator {
    
    private var navigationController: UINavigationController
    
    public var childCoordinators: [Coordinator] = []
    public var parentCoordiantor: Coordinator?
    
    private var homeViewController : HomeViewController?
    
    public init(navigationController : UINavigationController) {
        self.navigationController = navigationController
    }
    
    public func start() {
        let homeViewModel = HomeLogViewModel(useCase: DIContainer.shared.resolve(LogUseCase.self)!)
        let homeVC = HomeViewController(viewModel: homeViewModel)
        homeVC.coordinator = self
        navigationController.pushViewController(homeVC, animated: true)
        self.homeViewController = homeVC
    }
}

extension HomeCoordinator : HomeViewControllerDelgate {
    public func showBottomSheet() {
        let modalVC = NewLogSheetViewController()
        modalVC.delegate = homeViewController
        
        //모달 사이즈 설정
        let smallDetentId = UISheetPresentationController.Detent.Identifier("small")
        let smallDetent = UISheetPresentationController.Detent.custom(identifier: smallDetentId) { context in
            return UIScreen.main.bounds.height / 3.5
        }
        
        if let sheet = modalVC.sheetPresentationController{
            sheet.detents = [smallDetent]
            sheet.prefersGrabberVisible = true
            sheet.preferredCornerRadius = 30
            self.navigationController.present(modalVC, animated: true)
        }
    }
    
    //Log 생성 화면 이동
    public func navigateToCreateScreen(){
        let createLogViewModel = CreateLogViewModel(logUseCase: DIContainer.shared.resolve(LogUseCase.self)!)
        let createLogViewController = CreateLogViewController(viewModel: createLogViewModel)
        createLogViewController.hidesBottomBarWhenPushed = true
        self.navigationController.pushViewController(createLogViewController, animated: true)
    }
    
    //여행 전 TravelLog 화면 이동
    public func navigateToBeforeTravelView(log: Log) {
        let beforeTravelCoordinator = BeforeTravelCoordiantor(navigationController: self.navigationController, log: log)
        beforeTravelCoordinator.parentCoordiantor = self
        beforeTravelCoordinator.start()
        self.childCoordinators.append(beforeTravelCoordinator)
    }
    
    public func navigateToOnGoingTravelView(log: Log) {
        let onGoingTravelCoordinator = OnGoingTravelCoordinator(navigationController: self.navigationController, log: log)
        onGoingTravelCoordinator.parentCoordiantor = self
        onGoingTravelCoordinator.start()
        self.childCoordinators.append(onGoingTravelCoordinator)
    }
}
