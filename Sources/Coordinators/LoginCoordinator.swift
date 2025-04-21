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
        //온보딩 로그인 분기 설정
        // NOTE: 현재 온보딩 테스트 중이므로 조건 반전(!) 적용함.
        // 실제 서비스 배포 전에는 `if UserDefaultsManager.isFirstTime` 로 수정 필요.
        if UserDefaultsManager.isFirstTime {
            showOnBoarding()
        }
        else {
            showLogin()
        }
    }
}

//MARK: - Login Delegate

extension LoginCoordinator : LoginDelegate {
//    public func moveToTabbar() {
//        let appCoordinator = self.parentCoordiantor as! AppCoordinator
//        appCoordinator.startTabbarScene()
//        self.parentCoordiantor?.childDidFinish(self)
//        
//        //자동 Login 설정
//        UserDefaultsManager.isLoggined = true
//        //LoginView 제거해주기
//        self.navigationController.viewControllers.removeFirst()
//    }
    
    public func moveToProfileSetting() {
        let appCoordinator = self.parentCoordiantor as! AppCoordinator
        
        let profileSettingCoordinator = ProfileSettingCoordinator(navigationController: self.navigationController)
        profileSettingCoordinator.parentCoordiantor = appCoordinator
        appCoordinator.childCoordinators.append(profileSettingCoordinator)
        profileSettingCoordinator.start()
        
        self.parentCoordiantor?.childDidFinish(self)
    }
}

//MARK: - Onboarding, Login Flow

extension LoginCoordinator {
    
    private func makeLoginViewModel() -> LoginViewModel {
        let authUseCase = DIContainer.shared.resolve(AuthUseCase.self)!
        let loginService = LoginService(authUseCase: authUseCase)
        loginService.window = navigationController.view.window
        return LoginViewModel(loginService: loginService)
    }
    
    public func showOnBoarding() {
        let onBoardingViewController = OnBoardingViewController()
        onBoardingViewController.coordinator = self
        navigationController.pushViewController(onBoardingViewController, animated: true)
    }
    
    public func showLogin() {
        let viewModel = makeLoginViewModel()
        
        UserDefaultsManager.isFirstTime = false
        let loginViewController = LoginViewController(viewModel: viewModel)
        
        loginViewController.coordinator = self
        navigationController.pushViewController(loginViewController, animated: true)
    }
}
