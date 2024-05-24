//
//  Comment.swift
//  WithYou
//
//  Created by 김도경 on 1/11/24.
//  Copyright © 2024 withyou.org. All rights reserved.
//

import Foundation

public struct Comment {
    var postId : Int
    var memberId : Int
    var commentId : Int
    var content : String
    var replys : [Reply]
    
    public init(postId: Int, memberId: Int, commentId: Int, content: String, replys: [Reply]) {
        self.postId = postId
        self.memberId = memberId
        self.commentId = commentId
        self.content = content
        self.replys = replys
    }
}
