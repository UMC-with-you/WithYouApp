//
//  TabBarViewController.swift
//  WithYou
//
//  Created by 김도경 on 1/12/24.
//  Copyright © 2024 withyou.org. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        
        tabBar.barTintColor = .white
        tabBar.tintColor = UIColor(named: "MainColorDark")
        tabBar.layer.borderWidth = 0.3

        let mainView = MainViewController()
        let logView = TravelLogViewController()
        let myView = MyPageViewController()

        
        let nav1 = UINavigationController(rootViewController: mainView)
        let nav2 = UINavigationController(rootViewController: logView)
        let nav3 = UINavigationController(rootViewController: myView)
        
        
        nav1.tabBarItem = UITabBarItem(title: "HOME", image: UIImage(named: "HomeIcon"), tag: 1)
        nav2.tabBarItem = UITabBarItem(title: "TRAVELOG", image: UIImage(named: "TravelLogIcon"), tag: 2)
        nav3.tabBarItem = UITabBarItem(title: "MY", image: UIImage(named: "MyIcon"), tag: 3)

        setViewControllers([nav1,nav2,nav3], animated: false)
    }
    
}
