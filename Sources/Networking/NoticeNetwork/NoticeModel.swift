//
//  NoticeModel.swift
//  WithYou
//
//  Created by 김도경 on 2/8/24.
//  Copyright © 2024 withyou.org. All rights reserved.
//

import Foundation

struct NoticeResponse : Codable {
    var noticeId : Int
        var date : String
}

struct NoticeListResponse : Codable {
    var url : String
    var name : String
    var content : String
    var checkNum : Int
}
