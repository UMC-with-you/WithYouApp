//
//  MainLogViewModel.swift
//  WithYou
//
//  Created by 김도경 on 4/19/24.
//  Copyright © 2024 withyou.org. All rights reserved.
//

import RxCocoa
import Domain
import RxSwift

public class MainLogViewModel {
    public var useCase : LogUseCase
    
    public init(useCase : LogUseCase){
        self.useCase = useCase
    }
    var eclipsePosition : PublishRelay<Bool> = PublishRelay()
    
    var logs = PublishSubject<[Log]>()
    
    public func moveEclipseToIng(){
        self.eclipsePosition.accept(true)
    }
    
    public func moveEclipseToUpcoming(){
        self.eclipsePosition.accept(false)
    }
    
    public func loadLogs(){
        useCase.getAllLogs()
            .subscribe { [weak self] newLogs in
                self?.logs.onNext(newLogs)
            } onFailure: { error in
                print(error)
            }
            .disposed(by: DisposeBag())
    }
}
