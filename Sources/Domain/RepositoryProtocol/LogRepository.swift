//
//  LogRepository.swift
//  WithYou
//
//  Created by 김도경 on 5/5/24.
//  Copyright © 2024 withyou.org. All rights reserved.
//

import Foundation
import RxSwift

public protocol LogRepository {
    func getAllLogs() -> Single<[Log]>
    func addLog(title:String, startDate:String, endDate: String) -> Single<String>
    func deleteLog(travelId : Int) -> Single<Int>
    func editLog(travelId : Int, title:String?, startDate:String?, endDate: String?, localDate:Date?, image : Data?) -> Single<Int>
    func joinLog(inviteCode : String) -> Single<Void>
    func getAllLogMembers(travelId : Int) -> Single<[Traveler]>
    func getInviteCode(travelId : Int) -> Single<String>
    func leaveLog(travelId : Int , memberId : Int) -> Single<Int>
}
