//
//  TabbarCoordinator.swift
//  App
//
//  Created by 김도경 on 5/30/24.
//  Copyright © 2024 withyou.org. All rights reserved.
//



import Foundation
import UIKit

public class TabbarCoordinator : Coordinator {
    
    public var childCoordinators: [Coordinator] = []
    public var parentCoordiantor: Coordinator?
    
    private var navigationController : UINavigationController
    private var tabBarController: UITabBarController
    
    public init(navigationController : UINavigationController){
        self.navigationController = navigationController
        self.tabBarController = UITabBarController()
    }
    
    public func start() {
        let pages = TabbarPage.allCases
        let controllers: [UINavigationController] = pages.map {
            self.createTabNavigationController(page: $0)
        }
        self.configureTabbarController(with: controllers)
    }
    
    //각 탭 NavigationController 설정
    private func createTabNavigationController(page : TabbarPage) -> UINavigationController{
        let tabController = UINavigationController()
        tabController.setNavigationBarHidden(false, animated: false)
        tabController.tabBarItem = createTabBarItem(page: page)
        createTabCoordinator(page:page, controller : tabController)
        return tabController
    }
    
    //각 탭 Coordinator 생성 및 시작
    private func createTabCoordinator(page: TabbarPage, controller : UINavigationController) {
        switch page {
        case .home:
            self.createHomeCoordinator(with: controller)
        case .travelog:
            self.createTravelCoordinator(with: controller)
        case .my:
            self.createMyPageCoordinator(with: controller)
        }
    }
    
    //탭바Item 설정
    private func createTabBarItem(page: TabbarPage) -> UITabBarItem {
        UITabBarItem(title: page.tabTitle, image: page.tabIcon, tag: page.pageOrderNum)
    }
    
    //탭바 Appearance 설정
    private func configureTabbarController(with tabViewControllers: [UINavigationController]){
        tabBarController.setViewControllers(tabViewControllers, animated: false)
        tabBarController.navigationItem.hidesBackButton = true
        tabBarController.tabBar.barTintColor = .white
        tabBarController.tabBar.tintColor = WithYouAsset.mainColorDark.color
        tabBarController.tabBar.layer.borderWidth = 0.3
        self.navigationController.pushViewController(tabBarController, animated: true)
    }
    
    //HomeCoordinator 생성
    private func createHomeCoordinator(with controller : UINavigationController) {
        let homeCoordinator = HomeCoordinator(navigationController: controller)
        homeCoordinator.parentCoordiantor = self
        homeCoordinator.start()
        
        self.childCoordinators.append(homeCoordinator)
    }
    
    //TravelCoordinator 생성
    private func createTravelCoordinator(with controller : UINavigationController) {
        let travelCoordinator = TravelLogCoordinator(navigationController: controller)
        travelCoordinator.parentCoordiantor = self
        travelCoordinator.start()
        
        self.childCoordinators.append(travelCoordinator)
    }
    
    //MyPageCoordinator 생성
    private func createMyPageCoordinator(with controller : UINavigationController) {
        let myPageCoordinator = MyPageCoordinator(navigationController: controller)
        myPageCoordinator.parentCoordiantor = self
        myPageCoordinator.start()
        
        self.childCoordinators.append(myPageCoordinator)
    }
}

enum TabbarPage : String, CaseIterable {
    case home
    case travelog
    case my
    
    init?(index : Int) {
        switch index {
        case 1: self = .home
        case 2: self = .travelog
        case 3: self = .my
        default: return nil
        }
    }
    
    var pageOrderNum : Int {
        switch self {
        case .home : return 0
        case .travelog : return 1
        case .my : return 2
        }
    }
    
    var tabIcon : UIImage {
        switch self {
        case .home : return WithYouAsset.homeIcon.image
        case .travelog : return WithYouAsset.travelLogIcon.image
        case .my : return WithYouAsset.myIcon.image
        }
    }
    
    var tabTitle : String {
        switch self {
        case .home : return "HOME"
        case .travelog : return "TRAVELOG"
        case .my : return "MY"
        }
    }
}
