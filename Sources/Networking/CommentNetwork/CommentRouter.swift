//
//  CommentRouter.swift
//  WithYou
//
//  Created by 김도경 on 2/11/24.
//  Copyright © 2024 withyou.org. All rights reserved.
//

import Alamofire
import Foundation

enum CommentRouter {
    case addComment(postId : Int, content : Codable)
    case deleteComment(commentId : Int)
    case editComment(commentId: Int, content : Codable)
}

extension CommentRouter : BaseRouter {
    var baseURL: String {
        switch self {
        case .addComment : return Constants.baseURL + "/posts"
        case .deleteComment , .editComment : return Constants.baseURL + "/comments"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .addComment : return .post
        case .deleteComment : return .delete
        case .editComment : return .patch
        }
    }
    
    var path: String {
        switch self {
        case .addComment(let postId,_) :
            return "/\(postId)/comments"
        case .deleteComment(let commentId),.editComment(let commentId, _):
            return "/\(commentId)"
        }
    }
    
    var parameter: RequestParams {
        switch self {
        case .addComment(_,let content), .editComment(_,let content):
            return .body(content)
        case .deleteComment:
            return .none
        }
    }
    
    var header: HeaderType {
        return .withAuth
    }
    
    
}
