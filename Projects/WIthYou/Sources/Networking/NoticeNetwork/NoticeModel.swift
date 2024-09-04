//
//  NoticeModel.swift
//  WithYou
//
//  Created by 김도경 on 2/8/24.
//  Copyright © 2024 withyou.org. All rights reserved.
//

import Foundation

public struct NoticeResponse : Codable {
    var noticeId : Int
    var createdAt : String
}

public struct EditNoiceRequest : Codable {
    var noticeId: Int
    var state : Int
    var content : String
}
struct NoticeListResponse : Codable {
    var noticeId : Int
    var url : String?
    var name : String
    var content : String
    var checkNum : Int
}
