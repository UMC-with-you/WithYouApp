//
//  BeforeTravelSideBarViewModel.swift
//  HomeFeature
//
//  Created by 김도경 on 6/11/24.
//  Copyright © 2024 withyou.org. All rights reserved.
//


import RxCocoa
import RxSwift

public final class BeforeTravelSideBarViewModel {
    
    public let logUseCase : LogUseCase
    
    public var travelers : [Traveler]
    public let log : Log
    public var inviteCode : String = ""
    
    public let travelerRelay = PublishRelay<[Traveler]>()
  
    public init(logUseCase: LogUseCase, travelers: [Traveler], log: Log) {
        self.logUseCase = logUseCase
        self.travelers = travelers
        self.log = log
    }
    
    public func leaveLog() -> Single<Int>{
        logUseCase.leaveLog(travelId: log.id, memberId: 0)
    }
    
    public func loadTravelers(){
        self.travelerRelay.accept(travelers)
    }
    
    public func loadInviteCode() -> Single<String>{
        logUseCase.getInviteCode(travelId: log.id)
    }
}
