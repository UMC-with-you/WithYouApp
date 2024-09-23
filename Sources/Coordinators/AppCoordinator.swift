//
//  AppCoordinator.swift
//  App
//
//  Created by 김도경 on 5/26/24.
//  Copyright © 2024 withyou.org. All rights reserved.
//

import Foundation
import UIKit

class AppCoordinator : Coordinator {
    var childCoordinators: [Coordinator] = []
    var parentCoordiantor: Coordinator?
    
    private var navigationController : UINavigationController
   
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        prepareForDI()
    }
    
    func start() {
        // 만약 처음이라면 OnBoarding
        // OnBoarding을 했으면 Login
        // 로그인이 된 상태라면 로그인 진행
        if UserDefaultsManager.isLoggined {
            startTabbarScene()
        } else {
            startLoginScene()
        }
    }
    
    public func startTabbarScene(){
        let tabCoordinator = TabbarCoordinator(navigationController: navigationController)
        tabCoordinator.parentCoordiantor = self
        tabCoordinator.start()
        self.childCoordinators.append(tabCoordinator)
    }
    
    
    public func startLoginScene(){
        let loginCoordinator = LoginCoordinator(navigationController: self.navigationController)
        loginCoordinator.parentCoordiantor = self
        loginCoordinator.start()
        
        self.childCoordinators.append(loginCoordinator)
    }
    
    private func prepareForDI(){
        // Assuming DIContainer is already defined as mentioned previously
        let container = DIContainer.shared

        // Register Repositories (Concrete implementations for their respective protocols)
        container.register(AuthRepository.self) {
            MockAuthRepository() // Register DefaultAuthRepository for AuthRepository
        }

        container.register(LogRepository.self) {
            MockLogRepository() // Register DefaultLogRepository for LogRepository
        }

        container.register(MemberRepository.self) {
            DefaultMemberRepository() // Register DefaultMemberRepository for MemberRepository
        }

        container.register(NoticeRepository.self) {
            MockNoticeRepository() // Register DefaultNoticeRepository for NoticeRepository
        }

        container.register(PackingItemRepository.self) {
            MockPackingRepository() // Register DefaultPackingItemRepository for PackingItemRepository
        }

        container.register(PostRepository.self) {
            MockPostRepository() // Register DefaultPostRepository for PostRepository
        }

        container.register(RewindRepository.self) {
            DefaultRewindRepository() // Register DefaultRewindRepository for RewindRepository
        }

        container.register(SecureDataRepository.self) {
            DefaultSecureDataRepository() // Register DefaultSecureDataRepository for SecureDataRepository
        }

        // Register Use Cases (Concrete implementations with "Default" prefix in their initializers)
        container.register(AuthUseCase.self) {
            let repository = container.resolve(AuthRepository.self)!
            let secureRepo = container.resolve(SecureDataRepository.self)!
            return DefaultAuthUseCase(repository: repository,secureDataRepository: secureRepo)
        }

        container.register(LogUseCase.self) {
            let repository = container.resolve(LogRepository.self)!
            return DefaultLogUseCase(repository: repository)
        }

        container.register(MemberUseCase.self) {
            let repository = container.resolve(MemberRepository.self)!
            return DefaultMemberUseCase(repository: repository)
        }

        container.register(NoticeUseCase.self) {
            let repository = container.resolve(NoticeRepository.self)!
            return DefaultNoticeUseCase(repository: repository)
        }

        container.register(PackingItemUseCase.self) {
            let repository = container.resolve(PackingItemRepository.self)!
            return DefaultPackingItemUseCase(repository: repository)
        }

        container.register(PostUseCase.self) {
            let repository = container.resolve(PostRepository.self)!
            return DefaultPostUseCase(repository: repository)
        }

        container.register(RewindUseCase.self) {
            let repository = container.resolve(RewindRepository.self)!
            return DefaultRewindUseCase(repository: repository)
        }
    }
}

