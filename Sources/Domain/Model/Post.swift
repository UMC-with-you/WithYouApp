//
//  Post.swift
//  WithYou
//
//  Created by 김도경 on 2/11/24.
//  Copyright © 2024 withyou.org. All rights reserved.
//

import Foundation

public struct Post {
    public var postId : Int
    public var memberId : Int
    public var text : String
    public var comments : [Comment?]
    public var images : [PostImage]
    
    public init(postId: Int, memberId: Int, text: String, comments: [Comment], images: [PostImage]) {
        self.postId = postId
        self.memberId = memberId
        self.text = text
        self.comments = comments
        self.images = images
    }
    
}
