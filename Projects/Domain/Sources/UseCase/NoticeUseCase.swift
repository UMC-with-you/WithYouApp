//
//  NoticeUseCase.swift
//  WithYou
//
//  Created by 김도경 on 5/5/24.
//  Copyright © 2024 withyou.org. All rights reserved.
//

import RxSwift

public protocol NoticeUseCase {
    func createNotice(info: Dictionary<String,Any>, memberId : Int, logId: Int) -> Single<Void>
    func editNotice(notice: EditNoiceRequest) -> Single<Void>
    func getOneNotice(noticeId : Int) -> Single<Void>
    func deleteNotice(noticeId : Int) -> Single<Void>
    func getAllNoticeByLog(travelId : Int) -> Single<Void>
    func getAllNoticeByDate(travelId : Int) -> Single<Void>
}

final public class DefaultNoticeUseCase : NoticeUseCase {
    let repository : NoticeRepository
    
    public init(repository: NoticeRepository) {
        self.repository = repository
    }
    
    public func createNotice(info: Dictionary<String, Any>, memberId: Int, logId: Int) -> Single<Void> {
        repository.createNotice(info: info, memberId: memberId, logId: logId)
    }
    
    public func editNotice(notice: EditNoiceRequest) -> Single<Void> {
        repository.editNotice(notice: notice)
    }
    
    public func getOneNotice(noticeId: Int) -> Single<Void> {
        repository.getOneNotice(noticeId: noticeId)
    }
    
    public func deleteNotice(noticeId: Int) -> Single<Void> {
        repository.deleteNotice(noticeId: noticeId)
    }
    
    public func getAllNoticeByLog(travelId: Int) -> Single<Void> {
        repository.getAllNoticeByLog(travelId: travelId)
    }
    
    public func getAllNoticeByDate(travelId: Int) -> Single<Void> {
        repository.getAllNoticeByDate(travelId: travelId)
    }
    
    public func checkNotice() -> Single<Void>{
        repository.checkNotice()
    }
}
