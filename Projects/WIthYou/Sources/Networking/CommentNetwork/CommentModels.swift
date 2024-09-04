//
//  CommentModels.swift
//  WithYou
//
//  Created by 김도경 on 2/17/24.
//  Copyright © 2024 withyou.org. All rights reserved.
//

import Foundation

struct CommentIdResponse : Codable {
    var travelId : Int
}


struct CommentEditResponse : Codable {
    var replyId : Int
}
