//
//  DetailTravelViewModel.swift
//  TravelLogFeature
//
//  Created by 김도경 on 6/1/24.
//  Copyright © 2024 withyou.org. All rights reserved.
//

import Core
import Domain
import Foundation
import RxCocoa
import RxSwift

public class DetailTravelViewModel {
    
    private var disposeBag = DisposeBag()
    
    private var logUseCase : LogUseCase
    
    public var travelersRelay = PublishRelay<[Traveler]>()
    
    public init(logUseCase: LogUseCase) {
        self.logUseCase = logUseCase
    }
    
    public func getTravelerInfo(travelId : Int){
        logUseCase.getAllLogMembers(travelId: travelId)
            .subscribe { [weak self] travelers in
                self?.travelersRelay.accept(travelers)
            } onFailure: { error in
                print("error")
            }.disposed(by: disposeBag)
    }
}
