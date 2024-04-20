//
//  MainLogViewModel.swift
//  WithYou
//
//  Created by 김도경 on 4/19/24.
//  Copyright © 2024 withyou.org. All rights reserved.
//

import RxCocoa
import RxSwift

class MainLogViewModel {
    var eclipsePosition : PublishRelay<Bool> = PublishRelay()
    
    public func moveEclipseToIng(){
        self.eclipsePosition.accept(true)
    }
    
    public func moveEclipseToUpcoming(){
        self.eclipsePosition.accept(false)
    }
}
