//
//  Post.swift
//  WithYou
//
//  Created by 김도경 on 2/11/24.
//  Copyright © 2024 withyou.org. All rights reserved.
//

import Foundation


public struct Post : Codable, Equatable {
    var postId : Int
    var thumbnailUrl : String
}

struct LocalPostDTO : Codable {
    var postId : Int
    var travelId : Int
}

struct PostWithLogId : Codable {
    var post : Post
    var travelId : Int
}
