//
//  Coordinator.swift
//  Core
//
//  Created by 김도경 on 5/26/24.
//  Copyright © 2024 withyou.org. All rights reserved.
//

public protocol Coordinator : AnyObject {
    var childCoordinators : [Coordinator] { get set }
    var parentCoordiantor : Coordinator? { get set }
    func start()
}

extension Coordinator {
    public func childDidFinish(_ child: Coordinator?) {
        for (index, coordinator) in childCoordinators.enumerated() where coordinator === child {
            childCoordinators.remove(at: index)
            break
        }
    }
}
