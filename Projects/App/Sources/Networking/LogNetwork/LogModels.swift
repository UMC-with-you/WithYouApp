//
//  LogModels.swift
//  WithYou
//
//  Created by 김도경 on 2/6/24.
//  Copyright © 2024 withyou.org. All rights reserved.
//

import Foundation

//logId만 반환하는 Response
struct LogIDResponse : Codable{
    var travelId : Int
}

//log 참가 Response
struct LogJoinResponse : Codable {
    var memberId : Int
    var travelId : Int
}

struct InviteCodeResponse : Codable {
    var travelId : Int
    var invitationCode : String
}

struct EditLogRequest : Codable {
    var title : String
    var startDate : String
    var endDate : String
    var localDate : String
}
