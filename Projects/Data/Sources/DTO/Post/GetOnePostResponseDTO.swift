//
//  GetOnePostResponseDTO.swift
//  Data
//
//  Created by 김도경 on 5/24/24.
//  Copyright © 2024 withyou.org. All rights reserved.
//

import Foundation
import Domain

struct GetOnePostResponseDTO : Decodable {
    var commentDTOs : [CommentDTO]
    var postId : Int
    var memberid : Int
    var text : String
    var postMediaDTO :[PostMediaDTO]
}

struct PostMediaDTO : Decodable {
    var postMediaId : Int
    var url : String
    var position : Int
}

struct CommentDTO : Decodable {
    var memberId  : Int
    var commentId : Int
    var content : String
    var replyDTOs : [ReplyDTO]
}

struct ReplyDTO : Decodable {
    var replyId : Int
    var memberId : Int
    var content : String
}

extension GetOnePostResponseDTO {
    func toDomain() -> Post {
        return Post(postId: postId,
                          memberId: memberid,
                          text: text,
                          comments: commentDTOs.map{ $0.toDomain(postId: postId) },
                          images: postMediaDTO.map{ $0.toDomain() })
    }
}

extension PostMediaDTO {
    func toDomain() -> PostImage {
        return PostImage(imageId: postMediaId, imageUrl: url, position: position)
    }
}

extension CommentDTO {
    func toDomain(postId : Int) -> Comment {
        return Comment(postId: postId,
                       memberId: memberId,
                       commentId: commentId,
                       content: content,
                       replys: replyDTOs.map{ $0.toDomain(commnetId: commentId)})
    }
}

extension ReplyDTO {
    func toDomain(commnetId : Int) -> Reply {
        return Reply(commentId: commnetId, 
                     replyId: replyId,
                     content: content,
                     memberId: memberId)
    }
}
