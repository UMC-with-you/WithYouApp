//
//  OnGoingTravelViewModel.swift
//  WithYou
//
//  Created by bryan on 9/23/24.
//

import Foundation
import RxCocoa
import RxSwift

final public class OnGoingTravelViewModel {
    public let log : Log
    
    private let noticeUseCase : NoticeUseCase
    
    let notices = PublishRelay<[Notice]>()
    
    let disposeBag = DisposeBag()
    
    init(log: Log, noticeUseCase: NoticeUseCase) {
        self.log = log
        self.noticeUseCase = noticeUseCase
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
    
    public func checkNotice(noticeId : Int){
        noticeUseCase.checkNotice(noticeId: noticeId, memberId: 0)
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
    
    public func deleteNotice(noticeId : Int) {
        noticeUseCase.deleteNotice(noticeId: noticeId)
            .subscribe { [weak self] _ in
                self?.getNotices()
            } onFailure: { error in
                print(error)
            }
            .disposed(by: disposeBag)

    }
}
