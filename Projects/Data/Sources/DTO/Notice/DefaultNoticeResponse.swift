//
//  DefaultNoticeResponse.swift
//  Data
//
//  Created by 김도경 on 5/17/24.
//  Copyright © 2024 withyou.org. All rights reserved.
//

import Foundation

public struct DefaultNoticeResponse : Decodable {
    public let noticeId : Int
    public let createdAt : String
}
