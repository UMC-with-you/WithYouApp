//
//  LoginCoordinator.swift
//  LoginFeature
//
//  Created by 김도경 on 5/26/24.
//  Copyright © 2024 withyou.org. All rights reserved.
//

import UIKit

public class LoginCoordinator : Coordinator {
    
    private var navigationController: UINavigationController
    
    public var childCoordinators: [Coordinator] = []
    public var parentCoordiantor: Coordinator?
    
    public init(navigationController : UINavigationController) {
        self.navigationController = navigationController
    }
    
    public func start() {
        let authRepository = MockAuthRepository()
        let secureRepository = DefaultSecureDataRepository()
        
        let authUseCase = DefaultAuthUseCase(repository: authRepository, secureDataRepository: secureRepository)
        let loginService = LoginService(authUseCase: authUseCase)
        
        let viewModel = LoginViewModel(loginService: loginService)
        
        //온보딩 로그인 분기 설정
        if UserDefaultsManager.isFirstTime {
            UserDefaultsManager.isFirstTime = false
            let loginViewController = LoginViewController(viewModel: viewModel)
            
            loginViewController.coordinator = self
            navigationController.pushViewController(loginViewController, animated: true)
            loginService.window = navigationController.view.window
        } else {
            let loginViewController = OnBoardingViewController(viewModel: viewModel)
            
            loginViewController.coordinator = self
            navigationController.pushViewController(loginViewController, animated: true)
            loginService.window = navigationController.view.window
        }
        
    }
}

extension LoginCoordinator : LoginDelegate {
    public func moveToTabbar() {
        let appCoordinator = self.parentCoordiantor as! AppCoordinator
        appCoordinator.startTabbarScene()
        self.parentCoordiantor?.childDidFinish(self)
        
        //자동 Login 설정
        UserDefaultsManager.isLoggined = true
        //LoginView 제거해주기
        self.navigationController.viewControllers.removeFirst()
    }
}
