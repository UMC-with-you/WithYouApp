//
//  NoticeRepositoryImpl.swift
//  Data
//
//  Created by 김도경 on 5/17/24.
//  Copyright © 2024 withyou.org. All rights reserved.
//

import Foundation
import RxSwift

final public class DefaultNoticeRepository : NoticeRepository{
    
    private let service : BaseService = BaseService()
    
    public func createNotice(state: Int, content: String, memberId: Int, logId: Int) -> Single<Int> {
        let dto = CreateNoticeRequestDTO(memberId: memberId, logId: logId, state: state, content: content)
        let router = NoticeRouter.createNotice(noticeDTO: dto)
        return service.request(DefaultNoticeResponse.self, router: router).map{ $0.noticeId }
    }
    
    public func editNotice(noticeId : Int, state: Int, content : String) -> Single<Int> {
        let dto = EditNoticeRequestDTO(noticeId: noticeId, state: state, content: content)
        let router = NoticeRouter.editNotice(noticeDTO: dto)
        return service.request(DefaultNoticeResponse.self, router: router).map{ $0.noticeId }
    }
    
    public func getOneNotice(noticeId: Int) -> Single<Int> {
        let router = NoticeRouter.getOneNotice(noticeId: noticeId)
        return service.request(DefaultNoticeResponse.self, router: router).map{ $0.noticeId }
    }
    
    public func deleteNotice(noticeId: Int) -> Single<Int> {
        let router = NoticeRouter.deleteNotice(noticeId: noticeId)
        return service.request(DefaultNoticeResponse.self, router: router).map{ $0.noticeId }
    }
    
    //Notice stat 계산을 위한 해당 log의 day 필요
    public func getAllNotice(travelId: Int, day : Int) -> Single<[Notice]> {
        let router = NoticeRouter.getAllNoticeByLog(travelId: travelId)
        return service.request(GetNoticeResponseDTO.self, router: router).map{ $0.toDomain(day: day) }
    }
    
    public func checkNotice(noticeId : Int, memberId : Int) -> Single<Int> {
        let router = NoticeRouter.checkNotice(noticeId: noticeId, memeberId: memberId)
        return service.request(DefaultNoticeResponse.self, router: router).map{ $0.noticeId }
    }
}
