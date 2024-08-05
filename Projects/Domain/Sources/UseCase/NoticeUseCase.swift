//
//  NoticeUseCase.swift
//  WithYou
//
//  Created by 김도경 on 5/5/24.
//  Copyright © 2024 withyou.org. All rights reserved.
//

import RxSwift

public protocol NoticeUseCase {
    func createNotice(state: Int, content: String, memberId: Int, logId: Int) -> Single<Int>
    func editNotice(noticeId : Int, state: Int, content : String) -> Single<Int>
    func getOneNotice(noticeId : Int) -> Single<Int>
    func deleteNotice(noticeId : Int) -> Single<Int>
    func getAllNotice(travelId : Int, day : Int) -> Single<[Notice]>
    func checkNotice(noticeId : Int, memberId : Int) -> Single<Int>
}

final public class DefaultNoticeUseCase : NoticeUseCase {
    let repository : NoticeRepository
    
    public init(repository: NoticeRepository) {
        self.repository = repository
    }
    
    public func createNotice(state: Int, content: String, memberId: Int, logId: Int) -> Single<Int> {
        repository.createNotice(state: state, content: content, memberId: memberId, logId: logId)
    }
    
    public func editNotice(noticeId : Int, state: Int, content : String) -> Single<Int> {
        repository.editNotice(noticeId: noticeId, state: state, content: content)
    }
    
    public func getOneNotice(noticeId: Int) -> Single<Int> {
        repository.getOneNotice(noticeId: noticeId)
    }
    
    public func deleteNotice(noticeId : Int) -> Single<Int> {
        repository.deleteNotice(noticeId: noticeId)
    }
    
    public func getAllNotice(travelId: Int, day : Int) -> Single<[Notice]> {
        repository.getAllNotice(travelId: travelId, day : day)
    }
    
    public func checkNotice(noticeId : Int, memberId : Int) -> Single<Int>{
        repository.checkNotice(noticeId: noticeId, memberId: memberId)
    }
}
