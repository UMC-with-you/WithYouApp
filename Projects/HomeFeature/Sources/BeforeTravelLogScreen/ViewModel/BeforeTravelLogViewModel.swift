//
//  BeforeTravelLogViewModel.swift
//  HomeFeature
//
//  Created by 김도경 on 6/1/24.
//  Copyright © 2024 withyou.org. All rights reserved.
//

import Domain
import Foundation
import RxCocoa
import RxSwift

public final class BeforeTravelLogViewModel {
    
    private var disposeBag = DisposeBag()
    let noticeUseCase : NoticeUseCase
    let logUseCase : LogUseCase
    let packingUseCase : PackingItemUseCase
    
    let log : Log
    
    var travelers : [Traveler] = []
    
    //Relay
    let notices = PublishRelay<[Notice]>()
    let packingItems = PublishRelay<[PackingItem]>()
    
    public init(log: Log, noticeUseCase: NoticeUseCase, logUseCase: LogUseCase, packingUseCase: PackingItemUseCase) {
        self.noticeUseCase = noticeUseCase
        self.logUseCase = logUseCase
        self.log = log
        self.packingUseCase = packingUseCase
    }
    
    public func getNotices(){
        noticeUseCase.getAllNotice(travelId: log.id, day: 0)
            .subscribe { [weak self] newNotices in
                self?.notices.accept(newNotices)
            } onFailure: { error in
                print(error)
            }
            .disposed(by: disposeBag)

    }
    
    public func deleteNotice(noticeId : Int) {
        noticeUseCase.deleteNotice(noticeId: noticeId)
            .subscribe { [weak self] _ in
                self?.getNotices()
            } onFailure: { error in
                print(error)
            }
            .disposed(by: disposeBag)

    }
    
    public func addNotice(state: String, content: String) {
        noticeUseCase.createNotice(state: 0, content: content, memberId: 0, logId: log.id)
            .subscribe { [weak self] result in
                self?.getNotices()
                print("result")
            } onFailure: { error in
                print("error")
            }.disposed(by: disposeBag)
    }
    
    public func checkNotice(noticeId : Int){
        noticeUseCase.checkNotice(noticeId: noticeId, memberId: 0)
            .subscribe { [weak self] _ in
                self?.getNotices()
            } onFailure: { error in
                print(error)
            }
            .disposed(by: disposeBag)

    }
    
    public func editNotice(){
        
    }
    
    public func getTravelers(){
        logUseCase.getAllLogMembers(travelId: log.id)
            .subscribe { [weak self] travelers in
                self?.travelers = travelers
            } onFailure: { error in
                print(error)
            }.disposed(by: disposeBag)
    }
    
    public func getPackingItems(){
        packingUseCase.getItemList(travelId: log.id)
            .subscribe { [weak self] items in
                self?.packingItems.accept(items)
            } onFailure: { error in
                print(error)
            }
            .disposed(by: disposeBag)
    }
}
