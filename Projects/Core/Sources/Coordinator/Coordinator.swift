//
//  Coordinator.swift
//  Core
//
//  Created by 김도경 on 5/26/24.
//  Copyright © 2024 withyou.org. All rights reserved.
//

public protocol Coordinator : AnyObject {
    var childCoordinaotrs : [Coordinator] { get set }
    func start()
}
