//
//  CommentService.swift
//  WithYou
//
//  Created by 김도경 on 2/11/24.
//  Copyright © 2024 withyou.org. All rights reserved.
//

import Foundation

class CommentService : BaseService {
    static let shared = CommentService()
    override init(){}
    
    //댓글 작성
    func addComment(postId : Int, content : String,_ completion : @escaping (Any) -> Void){
        requestReturnsData(Comment.self, router: CommentRouter.addComment(postId: postId, content: ContentRequest(content: content)), completion: completion)
    }
    
    //댓글 삭제
    func deleteComment(commentId : Int,_ completion : @escaping (Any) -> Void){
        requestReturnsData(LogIDResponse.self, router: CommentRouter.deleteComment(commentId: commentId), completion: completion)
    }
    
    //댓글 수정
    func editComment(commentId : Int, content : String,_ completion : @escaping (Any) -> Void){
        requestReturnsData(ReplyIDResponse.self, router: CommentRouter.editComment(commentId: commentId, content: ContentRequest(content:content)), completion: completion)
    }
}
