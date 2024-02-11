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
    public func getAllLogs(_ completion: @escaping (Any)-> ()) {
        requestReturnsData([Log].self, router: LogRouter.getAllLog,completion: completion)
    }
    
    //로그 추가
    public func addLog(log : Log,_ completion: @escaping (Any)-> ()){
        requestReturnsData(LogIDResponse.self, router: LogRouter.addLog(log: log), completion: completion)
    }
    
    //로그 삭제
    public func deleteLog(logId : Int , _ completion: @escaping (Any) -> ()){
        requestReturnsData(LogIDResponse.self, router: LogRouter.deleteLog(travelId: logId), completion: completion)
    }
    
    //로그 수정
    public func editLog(logId : Int,_ completion: @escaping (Any) -> ()){
        requestReturnsData(LogIDResponse.self, router: LogRouter.editLog(travelId: logId), completion: completion)
    }
    
    //로그 참가
    public func joinLog(invitationCode : String, _ completion: @escaping (Any) -> ()){
        requestReturnsData(LogJoinResponse.self, router: LogRouter.joinLog(inviteCode: invitationCode), completion: completion)
    }
    
    //로그 참여한 모든 멤버 불러오기
    public func getAllMembers(logId : Int, _ completion: @escaping (Any) -> ()){
        requestReturnsData(Traveler.self, router: LogRouter.getAllLogMemebers(travelId: logId), completion: completion)
    }
    
    //로그 초대 코드 가져오기
    public func getInviteCode(logId : Int , _ completion: @escaping (Any) -> ()){
        requestReturnsData(InviteCodeResponse.self, router: LogRouter.getInviteCode(travelId: 3), completion: completion)
    }
    
}

