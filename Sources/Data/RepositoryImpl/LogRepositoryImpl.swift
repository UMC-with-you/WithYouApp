//
//  LogRepositoryImpl.swift
//  Data
//
//  Created by 김도경 on 5/9/24.
//  Copyright © 2024 withyou.org. All rights reserved.
//

import Foundation
import RxSwift

final public class DefaultLogRepository : LogRepository {
    
    private let service : BaseService = BaseService()
    
    public init(){}
    
    public func getAllLogs() -> Single<[Log]> {
        let router = LogRouter.getAllLog
        return service.request([Log].self, router: router)
    }
    
    /// 로그 추가하기
    public func addLog(title: String, startDate: String, endDate: String, image: Data?) -> Single<Int> {
        let requestDTO = AddLogRequestDTO(title: title, startDate: startDate, endDate: endDate, localDate: Date().getCurrentDateToString())
        let router = LogRouter.addLog(logDTO: requestDTO, image: image)
        return service.requestWithImage(LogIDResponseDTO.self, router: router).map{ $0.travelId }
    }
    
    public func deleteLog(travelId: Int) -> Single<Int> {
        let router = LogRouter.deleteLog(travelId: travelId)
        return service.request(LogIDResponseDTO.self, router: router).map{ $0.travelId }
    }
    
    public func editLog(travelId: Int, title: String?, startDate: String?, endDate: String?, localDate: Date?, image: Data?) -> Single<Int> {
        let requestDTO = AddLogRequestDTO(title: title!, startDate: startDate!, endDate: endDate!, localDate: "")
        let router = LogRouter.editLog(travelId: travelId, editRequest: requestDTO, image: image)
        return service.requestWithImage(LogIDResponseDTO.self, router: router).map{ $0.travelId }
    }
    
    public func joinLog(inviteCode: String) -> Single<Void> {
        let requestDTO = JoinLogRequestDTO(invitationCode: inviteCode)
        let router = LogRouter.joinLog(inviteCodeDTO: requestDTO)
        return service.request(JoinLogResponse.self, router: router).map{ _ in () }
    }
    
    public func getAllLogMembers(travelId: Int) -> Single<[Traveler]> {
        let router = LogRouter.getAllLogMemebers(travelId: travelId)
        return service.request([Traveler].self, router: router)
    }
    
    public func getInviteCode(travelId: Int) -> Single<String> {
        let router = LogRouter.getInviteCode(travelId: travelId)
        return service.request(InviteCodeResponse.self, router: router).map{ $0.invitationCode }
    }
    
    public func leaveLog(travelId: Int, memberId: Int) -> Single<Int> {
        let router = LogRouter.leaveLog(travelId: travelId, memberId: memberId)
        return service.request(JoinLogResponse.self, router: router).map{ $0.travelId }
    }
    
    
}
