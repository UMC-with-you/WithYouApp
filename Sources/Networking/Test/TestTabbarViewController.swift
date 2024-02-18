//
//  TestTabbarViewController.swift
//  WithYou
//
//  Created by 김도경 on 2/14/24.
//  Copyright © 2024 withyou.org. All rights reserved.
//

import Foundation
import UIKit

class TestTabbarViewController : TabBarViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        
        tabBar.barTintColor = .white
        tabBar.tintColor = UIColor(named: "MainColorDark")
        tabBar.layer.borderWidth = 0.3
        
        let nav1 = UINavigationController(rootViewController: TravelLogTest())
        let nav2 = UINavigationController(rootViewController: NoticeTestViewController())
        let nav3 = UINavigationController(rootViewController: PackingItemTestViewController())
        let nav4 = UINavigationController(rootViewController: RewindTestViewController())
        let nav5 = UINavigationController(rootViewController: PostTestViewController())
        let nav6 = UINavigationController(rootViewController: CommentTestViewController())
        let nav7 = UINavigationController(rootViewController: ReplyTestViewController())
        let nav8 = UINavigationController(rootViewController: CloudTestViewController())
        
        nav1.tabBarItem = UITabBarItem(title: "Travel", image: UIImage(named: "HomeIcon"), tag: 1)
        nav2.tabBarItem = UITabBarItem(title: "Notice", image: UIImage(named: "TravelLogIcon"), tag: 2)
        nav3.tabBarItem = UITabBarItem(title: "Packing", image: UIImage(named: "MyIcon"), tag: 3)
        nav4.tabBarItem = UITabBarItem(title: "Rewind", image: UIImage(named: "MyIcon"), tag: 4)
        nav5.tabBarItem = UITabBarItem(title: "Post", image: UIImage(named: "MyIcon"), tag: 5)
        nav6.tabBarItem = UITabBarItem(title: "Comment", image: UIImage(named: "MyIcon"), tag: 6)
        nav7.tabBarItem = UITabBarItem(title: "Reply", image: UIImage(named: "MyIcon"), tag: 7)
        nav8.tabBarItem = UITabBarItem(title: "Reply", image: UIImage(named: "MyIcon"), tag: 8)
        setViewControllers([nav1,nav2,nav3,nav4,nav5,nav6,nav7,nav8], animated: false)
    }
}
