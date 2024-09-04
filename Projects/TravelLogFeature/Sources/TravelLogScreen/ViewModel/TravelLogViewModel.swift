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

public class TravelLogViewModel {
    // MARK: Properties
    private var logUseCase : LogUseCase
    private var disposeBag = DisposeBag()
    
    // Subjects
    public var logs : PublishSubject<[Log]> = PublishSubject()
    
    // MARK: Functions
    public init(useCase : LogUseCase){
        self.logUseCase = useCase
    }
    
    func loadLogs(){
        logUseCase.getAllLogs()
            .subscribe { [weak self] newLogs in
                self?.logs.onNext(newLogs.filter{$0.status == "BYGONE"})
            } onFailure: { error in
                print(error)
            }.disposed(by: disposeBag)
    }
    
    public func joinLog(_ invitationCode : String){
        logUseCase.joinLog(inviteCode: invitationCode)
            .subscribe { _ in
                self.loadLogs()
            } onFailure: { error in
                print("Error")
            }
            .disposed(by: disposeBag)
    }
    
}
