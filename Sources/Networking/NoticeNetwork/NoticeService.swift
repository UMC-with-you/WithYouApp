//
//  NoticeService.swift
//  WithYou
//
//  Created by 김도경 on 2/8/24.
//  Copyright © 2024 withyou.org. All rights reserved.
//

import Foundation

class NoticeService : BaseService {
    static let shared = NoticeService()
    override private init(){}
    
    //Notice 생성
    func createNotice(notice : Notice, memberId : Int, logId: Int,_ completion : @escaping (Any)-> Void){
        requestReturnsData(NoticeResponse.self, router: NoticeRouter.createNotice(notice: notice.asNewNoticeRequest(memberId: memberId, logId: logId)), completion: completion)
    }
    
    //Notice 수정
    func editNotice(notice : Notice, _ completion: @escaping (Any)-> Void){
        requestReturnsData(NoticeResponse.self, router: NoticeRouter.editNotice(notice: notice.asEditNoticeRequest()), completion: completion)
    }
    
    //Notice 단건 조회
    func getOneNotice(noticeId : Int, _ completion : @escaping (Any) -> Void){
        requestReturnsData(NoticeResponse.self, router: NoticeRouter.getOneNotice(noticeId: noticeId), completion: completion)
    }
    
    //Notice 삭제
    func deleteNotice(noticeId : Int, _ completion : @escaping (Any) -> Void){
        requestReturnsData(NoticeResponse.self, router: NoticeRouter.deleteNotice(noticeId: noticeId), completion: completion)
    }
    
    //TravelLog의 모든 Notice 조회
    func getAllNoticByLog(travelId : Int,logId : Int,_ completion : @escaping (Any) -> Void){
        requestReturnsData([NoticeListResponse].self, router: NoticeRouter.getAllNoticeByLog(travelId: travelId, logId: logId), completion: completion)
    }
    

    func getAllNoticeByDate(travelId : Int,logId : Int,_ completion : @escaping (Any) -> Void){
        requestReturnsData([NoticeListResponse].self, router: NoticeRouter.getAllNoticeByDate(travelId: travelId, logId: logId), completion: completion)
    }
    
}
