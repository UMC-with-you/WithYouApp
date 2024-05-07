//
//  GridTravelLogViewModel.swift
//  WithYou
//
//  Created by 김도경 on 5/3/24.
//  Copyright © 2024 withyou.org. All rights reserved.
//

import RxSwift
import Domain
import UIKit

struct GridTravelLogViewModel {
    
    var logs = BehaviorSubject<[Log]>(value: [])
    
    func getLogs(){
        logs.onNext(LogManager.shared.getMockLogs())
    }
    
}
