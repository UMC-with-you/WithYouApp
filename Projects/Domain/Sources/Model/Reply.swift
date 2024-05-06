//
//  Reply.swift
//  WithYou
//
//  Created by 김도경 on 2/11/24.
//  Copyright © 2024 withyou.org. All rights reserved.
//

import Foundation

public struct Reply : Codable {
    var commentId : Int
    var replyId : Int
    var content : String
}
