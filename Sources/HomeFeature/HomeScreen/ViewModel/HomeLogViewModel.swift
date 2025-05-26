//
//  HomeLogViewModel.swift
//  WithYou
//
//  Created by 김도경 on 4/19/24.
//  Copyright © 2024 withyou.org. All rights reserved.
//

import RxCocoa
import RxSwift

public final class HomeLogViewModel {
    // MARK: Properties
    private var disposeBag = DisposeBag()
    private var useCase : LogUseCase
    
    private var ingLogs : [Log] = []
    private var upcommingLogs : [Log] = []
    
    // Relays
    var eclipsePosition : PublishRelay<Bool> = PublishRelay()
    var isLogEmpty : BehaviorRelay<Bool> = BehaviorRelay(value: true)
    
    // Subjects
    var logs = PublishSubject<[Log]>()
    
    // MARK: Initializer
    public init(useCase : LogUseCase){
        self.useCase = useCase
    }
    
    // MARK: Functions
    public func ingTapped(){
        self.eclipsePosition.accept(true)
        self.logs.onNext(ingLogs)
    }
    
    public func upcomingTapped(){
        self.eclipsePosition.accept(false)
        self.logs.onNext(upcommingLogs)
    }
    
    public func loadLogs(){
        useCase.getAllLogs()
            .subscribe { [weak self] newLogs in
                if newLogs.isEmpty {
                    self?.isLogEmpty.accept(true)
                } else {
                    self?.classifyLog(newLogs)
                }
            } onFailure: { error in
                print(error)
            }
            .disposed(by: disposeBag)
    }
    
    public func joinLog(_ invitationCode : String){
        useCase.joinLog(inviteCode: invitationCode)
            .subscribe { _ in
                self.loadLogs()
            } onFailure: { error in
                print("Error")
            }
            .disposed(by: disposeBag)

    }
    
    private func classifyLog(_ newLogs : [Log]){
        self.ingLogs = newLogs.filter{ $0.status == "ONGOING" }
        self.upcommingLogs = newLogs.filter{ $0.status == "BEFORE" }
        self.eclipsePosition.accept(ingLogs.isEmpty ? false : true)
        self.logs.onNext( !ingLogs.isEmpty ? ingLogs : upcommingLogs )
        self.isLogEmpty.accept(false)
    }
}
