//
//  Comment.swift
//  WithYou
//
//  Created by 김도경 on 1/11/24.
//  Copyright © 2024 withyou.org. All rights reserved.
//

import Foundation

struct Comment : Codable {
    var postId : Int
    var memberId : Int
    var commentId : Int
    var content : String
}
