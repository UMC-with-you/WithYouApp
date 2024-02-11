//
//  ReplyRouter.swift
//  WithYou
//
//  Created by 김도경 on 2/11/24.
//  Copyright © 2024 withyou.org. All rights reserved.
//

import Alamofire
import Foundation

enum ReplyRouter {
    case addReply(commentId : Int, content : Codable)
    case deleteReply(replyId : Int)
    case editReply(replyId : Int, content : Codable)
}

extension ReplyRouter : BaseRouter {
    var baseURL: String {
        switch self{
        case .addReply :
            return Constants.baseURL + "/comments"
        case .deleteReply , .editReply :
            return Constants.baseURL + "/replies"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .addReply: return .post
        case .deleteReply : return .delete
        case .editReply : return .patch
        }
    }
    
    var path: String {
        switch self {
        case .addReply(let commentId,_): return "/\(commentId)"
        case .deleteReply(let replyId) : return "/\(replyId)"
        case .editReply(let replyId,_) : return "/\(replyId)"
        }
    }
    
    var parameter: RequestParams {
        switch self {
        case .addReply(_,let content), .editReply(_,let content):
            return .body(content)
        case .deleteReply:
            return .none
        }
    }
    
    var header: HeaderType {
        return .withAuth
    }
    
    
}
