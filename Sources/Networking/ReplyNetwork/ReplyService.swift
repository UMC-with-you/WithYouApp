//
//  ReplyService.swift
//  WithYou
//
//  Created by 김도경 on 2/11/24.
//  Copyright © 2024 withyou.org. All rights reserved.
//

import Foundation

class ReplyService : BaseService {
    static let shared = ReplyService()
    override private init(){}
    
    //대댓글 추가
    func addReply(commentId : Int, content : String,_ completion : @escaping (Any) -> Void){
        requestReturnsData(Reply.self, router: ReplyRouter.addReply(commentId: commentId, content: ContentRequest(content: content)), completion: completion)
    }
    
    //대댓글 삭제
    func deleteReply(replyId: Int, _ completion : @escaping (Any) -> Void){
        requestReturnsData(LogIDResponse.self, router: ReplyRouter.deleteReply(replyId: replyId), completion: completion)
    }
    
    //대댓글 수정
    func editReply(replyId : Int, content : String,_ completion : @escaping (Any) -> Void){
        requestReturnsData(ReplyIDResponse.self, router: ReplyRouter.editReply(replyId: replyId, content: ContentRequest(content: content)), completion: completion)
    }
}
