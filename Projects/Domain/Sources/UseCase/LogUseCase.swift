//
//  LogUseCase.swift
//  WithYou
//
//  Created by 김도경 on 5/5/24.
//  Copyright © 2024 withyou.org. All rights reserved.
//

import Foundation
import UIKit
import RxSwift

public protocol LogUseCase {
    func addLog(title:String, startDate:String, endDate: String, localDate:Date, image : UIImage) -> Single<Void>
    func deleteLog(travelId : Int) -> Single<Void>
    func editLog(travelId : Int, title:String?, startDate:String?, endDate: String?, localDate:Date?, image : UIImage?) -> Single<Void>
    func joinLog(inviteCode : String) -> Single<Void>
    func getAllLogMembers(travelId : Int) -> Single<[Traveler]>
    func getInviteCode(travelId : Int) -> Single<InviteCodeResponse>
    func leaveLog(travelId : Int , memberId : Int) -> Single<Void>
}

public final class DefaultLogUseCase : LogUseCase {
    
    let repository : LogRepository
    
    init(repository: LogRepository) {
        self.repository = repository
    }
    
    public func addLog(title: String, startDate: String, endDate: String, localDate: Date, image: UIImage) -> Single<Void> {
        repository.addLog(title: title, startDate: startDate, endDate: endDate, localDate: localDate, image: image)
    }
    
    public func deleteLog(travelId: Int) -> Single<Void> {
        repository.deleteLog(travelId: travelId)
    }
    
    public func editLog(travelId: Int, title: String?, startDate: String?, endDate: String?, localDate: Date?, image: UIImage?) -> Single<Void> {
        repository.editLog(travelId: travelId, title: title, startDate: startDate, endDate: endDate, localDate: localDate, image: image)
    }
    
    public func joinLog(inviteCode: String) -> Single<Void> {
        repository.joinLog(inviteCode: inviteCode)
    }
    
    public func getInviteCode(travelId: Int) -> Single<InviteCodeResponse> {
        repository.getInviteCode(travelId: travelId)
    }
    
    
    public func getAllLogMembers(travelId: Int) -> Single<[Traveler]> {
        repository.getAllLogMembers(travelId: travelId)
    }
    
    public func leaveLog(travelId: Int, memberId: Int) -> Single<Void> {
        repository.leaveLog(travelId: travelId, memberId: memberId)
    }
    
   
}
