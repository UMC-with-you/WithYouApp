//
//  Reply.swift
//  WithYou
//
//  Created by 김도경 on 2/11/24.
//  Copyright © 2024 withyou.org. All rights reserved.
//

import Foundation

public struct Reply {
    var commentId : Int
    var replyId : Int
    var content : String
    var memberId : Int
    
    public init(commentId: Int, replyId: Int, content: String, memberId: Int) {
        self.commentId = commentId
        self.replyId = replyId
        self.content = content
        self.memberId = memberId
    }
}
