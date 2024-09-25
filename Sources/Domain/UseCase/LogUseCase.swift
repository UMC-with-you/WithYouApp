//
//  LogUseCase.swift
//  WithYou
//
//  Created by 김도경 on 5/5/24.
//  Copyright © 2024 withyou.org. All rights reserved.
//

import Foundation
import RxSwift

public protocol LogUseCase {
    func getAllLogs() -> Single<[Log]>
    func addLog(title:String, startDate:String, endDate: String, image : Data?) -> Single<Int>
    func deleteLog(travelId : Int) -> Single<Int>
    func editLog(travelId : Int, title:String?, startDate:String?, endDate: String?, localDate:Date?, image : Data?) -> Single<Int>
    func joinLog(inviteCode : String) -> Single<Void>
    func getAllLogMembers(travelId : Int) -> Single<[Traveler]>
    func getInviteCode(travelId : Int) -> Single<String>
    func leaveLog(travelId : Int , memberId : Int) -> Single<Int>
}

public final class DefaultLogUseCase : LogUseCase {
    
    let repository : LogRepository
    
    public init(repository: LogRepository) {
        self.repository = repository
    }
    
    public func getAllLogs() -> Single<[Log]> {
        repository.getAllLogs()
    }
    
    public func addLog(title: String, startDate: String, endDate: String, image: Data?) -> Single<Int> {
        repository.addLog(title: title, startDate: startDate, endDate: endDate, image: image)
    }
    
    public func deleteLog(travelId: Int) -> Single<Int> {
        repository.deleteLog(travelId: travelId)
    }
    
    public func editLog(travelId: Int, title: String?, startDate: String?, endDate: String?, localDate: Date?, image: Data?) -> Single<Int> {
        repository.editLog(travelId: travelId, title: title, startDate: startDate, endDate: endDate, localDate: localDate, image: image)
    }
    
    public func joinLog(inviteCode: String) -> Single<Void> {
        repository.joinLog(inviteCode: inviteCode)
    }
    
    public func getInviteCode(travelId: Int) -> Single<String> {
        repository.getInviteCode(travelId: travelId)
    }
    
    public func getAllLogMembers(travelId: Int) -> Single<[Traveler]> {
        repository.getAllLogMembers(travelId: travelId)
    }
    
    public func leaveLog(travelId: Int, memberId: Int) -> Single<Int> {
        repository.leaveLog(travelId: travelId, memberId: memberId)
    }
}
