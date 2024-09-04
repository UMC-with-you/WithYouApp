//
//  MyPageCoordinator.swift
//  App
//
//  Created by 김도경 on 6/1/24.
//  Copyright © 2024 withyou.org. All rights reserved.
//

import Core
import Data
import Domain
import Foundation
import UIKit

public final class MyPageCoordinator : Coordinator {
    public struct Dependecy {
        let navigationController : UINavigationController
    }
    
    public var childCoordinators: [Coordinator] = []
    public var parentCoordiantor: Coordinator?
    
    private var navigationController : UINavigationController
    
    public init(navigationController : UINavigationController) {
        self.navigationController = navigationController
    }
    
    public func start() {
    }
}
