//
//  LogService.swift
//  WithYou
//
//  Created by 김도경 on 2/6/24.
//  Copyright © 2024 withyou.org. All rights reserved.
//

import Alamofire
import Foundation

class LogService : BaseService {
    static let shared = LogService()
    private override init(){}
    
    //모든 여행 로그 조회
    public func getAllLogs(_ completion: @escaping ([Log])-> ()) {
        requestReturnsData([Log].self, router: LogRouter.getAllLog,completion: completion)
    }
    
    //로그 추가
    public func addLog(log : Log,_ completion: @escaping (LogIDResponse)-> ()){
        requestReturnsData(LogIDResponse.self, router: LogRouter.addLog(log: log), completion: completion)
    }
    
    //로그 삭제
    public func deleteLog(logId : Int , _ completion: @escaping (LogIDResponse) -> ()){
        requestReturnsData(LogIDResponse.self, router: LogRouter.deleteLog(travelId: logId), completion: completion)
    }
    
    //로그 수정
    public func editLog(logId : Int,editRequest : EditLogRequest,_ completion: @escaping (LogIDResponse) -> ()){
        requestReturnsData(LogIDResponse.self, router: LogRouter.editLog(travelId: logId,editRequest: editRequest), completion: completion)
    }
    
    //로그 참가
    public func joinLog(invitationCode : String, _ completion: @escaping (LogJoinResponse) -> ()){
        requestReturnsData(LogJoinResponse.self, router: LogRouter.joinLog(inviteCode: invitationCode), completion: completion)
    }
    
    //로그 참여한 모든 멤버 불러오기
    public func getAllMembers(logId : Int, _ completion: @escaping ([Traveler]) -> ()){
        requestReturnsData([Traveler].self, router: LogRouter.getAllLogMemebers(travelId: logId), completion: completion)
    }
    
    //로그 초대 코드 가져오기
    public func getInviteCode(logId : Int , _ completion: @escaping (InviteCodeResponse) -> ()){
        requestReturnsData(InviteCodeResponse.self, router: LogRouter.getInviteCode(travelId: logId), completion: completion)
    }
    
    //로그 나가기
    public func leaveLog(travelId : Int, memberId: Int, _ completion: @escaping (LogJoinResponse)->()){
        requestReturnsData(LogJoinResponse.self, router: LogRouter.leaveLog(travelId: travelId, memberId: memberId), completion: completion)
    }
    
}

