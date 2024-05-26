//
//  AppCoordinator.swift
//  App
//
//  Created by 김도경 on 5/26/24.
//  Copyright © 2024 withyou.org. All rights reserved.
//

import Core
import Foundation
import UIKit

class AppCoordinator : Coordinator {
    var childCoordinaotrs : [Coordinator] = []
    private var navigationController : UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        
    }
}
