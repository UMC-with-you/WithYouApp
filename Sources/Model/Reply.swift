//
//  Reply.swift
//  WithYou
//
//  Created by 김도경 on 2/11/24.
//  Copyright © 2024 withyou.org. All rights reserved.
//

import Foundation

struct Reply : Codable {
    var postId : Int
    var memberId : Int
    var commentId : Int
    var content : String
}
