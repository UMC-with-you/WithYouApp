//
//  PostModels.swift
//  WithYou
//
//  Created by 김도경 on 2/11/24.
//  Copyright © 2024 withyou.org. All rights reserved.
//

import Foundation
import UIKit


public struct NewPostStruct  {
    var text : String
    var mediaList : [UIImage]
}
struct NewPostRequest : Codable {
    var text : String
    var mediaList : [String]
}

struct EditPostRequest : Codable {
    var text : String
    var newPositions : [String :  Int]
}

struct PostIdResponse : Codable {
    var postId : Int
}

public struct OnePostResponse :Codable{
    var commentDTOs : [CommentDTO?]
    var postId : Int
    var memberid : Int
    var text : String
    var postMediaDTO :[PostMediaDTO]
}

struct PostMediaDTO : Codable {
    var postMediaId : Int
    var url : String
    var position : Int
}

struct CommentDTO : Codable{
    var memberId  : Int?
    var commentId : Int
    var content : String
    var replyDTOs : [ReplyDTO]
}
struct ReplyDTO : Codable {
    var replyId : Int
    var memberId : Int
    var content : String
}
