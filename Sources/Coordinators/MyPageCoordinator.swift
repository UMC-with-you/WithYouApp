//
//  MyPageCoordinator.swift
//  App
//
//  Created by 김도경 on 6/1/24.
//  Copyright © 2024 withyou.org. All rights reserved.
//

import Foundation
import UIKit

public final class MyPageCoordinator : Coordinator {
//    public struct Dependecy {
//        let navigationController : UINavigationController
//    }
    
    private var navigationController : UINavigationController
    
    public var childCoordinators: [Coordinator] = []
    public var parentCoordinator: Coordinator?
    
    private var myPageViewController : MyPageViewController?
    
    public init(navigationController : UINavigationController) {
        self.navigationController = navigationController
    }
    
    public func start() {
        let myPageViewModel = MyPageViewModel(useCase: DIContainer.shared.resolve(PostUseCase.self)!)
        let myPageVC = MyPageViewController(viewModel: myPageViewModel)
        myPageVC.coordinator = self
        navigationController.pushViewController(myPageVC, animated: true)
        self.myPageViewController = myPageVC
    }
}

extension MyPageCoordinator: MyPageViewControllerDelegate {
    public func navigateToSettings() {
        let settingsVC = SettingsViewController()
        navigationController.pushViewController(settingsVC, animated: false)
    }
}
