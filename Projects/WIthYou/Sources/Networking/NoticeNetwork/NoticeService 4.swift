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
    func createNotice(info : Dictionary<String,Any>, memberId : Int, logId: Int,_ completion : @escaping (NoticeResponse)-> Void){
        var noticeDic : [String : Any] = [
            "memberId" : memberId,
            "logId" : logId,
            "state" : info["state"]!,
            "content" : info["content"]!
        ]
        print(noticeDic)
        requestReturnsData(NoticeResponse.self, router: NoticeRouter.createNotice(notice: noticeDic), completion: completion)
    }
    
    //Notice 수정
    func editNotice(notice : EditNoiceRequest, _ completion: @escaping (NoticeResponse)-> Void){
        requestReturnsData(NoticeResponse.self, router: NoticeRouter.editNotice(notice: notice), completion: completion)
    }
    
    //Notice 단건 조회
    func getOneNotice(noticeId : Int, _ completion : @escaping (NoticeResponse) -> Void){
        requestReturnsData(NoticeResponse.self, router: NoticeRouter.getOneNotice(noticeId: noticeId), completion: completion)
    }
    
    //Notice 삭제
    func deleteNotice(noticeId : Int, _ completion : @escaping (Any) -> Void){
        requestReturnsData(NoticeResponse.self, router: NoticeRouter.deleteNotice(noticeId: noticeId), completion: completion)
    }
    
    //TravelLog의 모든 Notice 조회
    func getAllNoticByLog(travelId : Int,_ completion : @escaping ([NoticeListResponse]) -> Void){
        requestReturnsData([NoticeListResponse].self, router: NoticeRouter.getAllNoticeByLog(travelId: travelId), completion: completion)
    }
    

    func getAllNoticeByDate(travelId : Int,logId : Int,_ completion : @escaping ([NoticeListResponse]) -> Void){
        requestReturnsData([NoticeListResponse].self, router: NoticeRouter.getAllNoticeByDate(travelId: travelId), completion: completion)
    }
    
}
