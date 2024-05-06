//
//  LogRepository.swift
//  WithYou
//
//  Created by 김도경 on 5/5/24.
//  Copyright © 2024 withyou.org. All rights reserved.
//

import Foundation
import UIKit
import RxSwift

protocol LogRepository {
    func addLog(title:String, startDate:String, endDate: String, localDate:Date, image : UIImage) -> Single<Void>
    func deleteLog(travelId : Int) -> Single<Void>
    func editLog(travelId : Int, title:String?, startDate:String?, endDate: String?, localDate:Date?, image : UIImage?) -> Single<Void>
    func joinLog(inviteCode : String) -> Single<Void>
    func getAllLogMembers(travelId : Int) -> Single<[Traveler]>
    func getInviteCode(travelId : Int) -> Single<InviteCodeResponse>
    func leaveLog(travelId : Int , memberId : Int) -> Single<Void>
}

