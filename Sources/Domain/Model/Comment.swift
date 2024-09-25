//
//  Comment.swift
//  WithYou
//
//  Created by 김도경 on 1/11/24.
//  Copyright © 2024 withyou.org. All rights reserved.
//

import Foundation

public struct Comment {
    public let postId : Int
    public let memberId : Int
    public let commentId : Int
    public let content : String
    public let replys : [Reply]
    
    public init(postId: Int, memberId: Int, commentId: Int, content: String, replys: [Reply]) {
        self.postId = postId
        self.memberId = memberId
        self.commentId = commentId
        self.content = content
        self.replys = replys
    }
}
