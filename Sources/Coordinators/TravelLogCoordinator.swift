//
//  TravelLogCoordinator.swift
//  TravelLogFeature
//
//  Created by 김도경 on 5/31/24.
//  Copyright © 2024 withyou.org. All rights reserved.
//

import Foundation
import UIKit

public final class TravelLogCoordinator : Coordinator {
    
    public var childCoordinators: [Coordinator] = []
    public var parentCoordinator: Coordinator?
    
    private var navigationController : UINavigationController
    private var travelLogViewController : TravelLogViewController!
    
    public init(navigationController : UINavigationController){
        self.navigationController = navigationController
    }
    
    public func start() {
        let useCase = DIContainer.shared.resolve(LogUseCase.self)!
        let viewModel = TravelLogViewModel(useCase: useCase)
        let viewController = TravelLogViewController(viewModel: viewModel)
        viewController.coordinator = self
        
        self.navigationController.pushViewController(viewController, animated: false)
        
        self.travelLogViewController = viewController
    }
}

extension TravelLogCoordinator : TravelLogViewControllerDelgate {
    public func showBottomSheet() {
        let modalVC = NewLogSheetViewController()
        modalVC.delegate = travelLogViewController
        
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
    
    //로그 추가 스크린으로
    public func navigateToCreateScreen(){
        let useCase = DIContainer.shared.resolve(LogUseCase.self)!
        let createLogViewModel = CreateLogViewModel(logUseCase: useCase)
        let createLogViewController = CreateLogViewController(viewModel: createLogViewModel)
        createLogViewController.hidesBottomBarWhenPushed = true
        self.navigationController.pushViewController(createLogViewController, animated: true)
    }
    
    // 로그 선택시 DetailView로 이동
    public func navigateToDetailTravelLogView(to log : Log){
        let detailViewCoordinator = DetailTravelLogCoordinator(navigationController: self.navigationController, log: log)
        detailViewCoordinator.start()
        self.childCoordinators.append(detailViewCoordinator)
    }
}
