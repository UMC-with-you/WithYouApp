//
//  PostRouter.swift
//  WithYou
//
//  Created by 김도경 on 2/11/24.
//  Copyright © 2024 withyou.org. All rights reserved.
//

import Alamofire
import Foundation

enum PostRouter {
    case getAllPost(travelId : Int)
    case addPost(travelId : Int, newPost : Codable)
    case getOnePost(postId : Int, travelId : Int)
    case scrapPost(postId : Int)
    case deletePost(postId : Int)
    case editPost(postId : Int, editContent : Codable)
    case getScrapedPost
}

extension PostRouter : BaseRouter{
    var baseURL: String {
        switch self {
        case .getAllPost, .addPost :
            return Constants.baseURL + "/travels"
        case .getOnePost, .scrapPost, .deletePost, .editPost, .getScrapedPost :
            return Constants.baseURL + "/posts"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getAllPost, .getOnePost, .getScrapedPost :
            return .get
        case .addPost, .scrapPost :
            return .post
        case .deletePost :
            return .delete
        case .editPost :
            return .patch
        }
    }
    
    var path: String {
        switch self {
        case .getAllPost(let travelId), .addPost(let travelId, _):
            return "/\(travelId)/posts"
        case .getOnePost(let postId,_), .scrapPost(let postId), .deletePost(let postId), .editPost(let postId,_):
            return "/\(postId)"
        case .getScrapedPost:
            return ""
        }
    }
    
    var parameter: RequestParams {
        switch self {
        case .getAllPost, .scrapPost,.deletePost, .getScrapedPost :
            return .none
        case .addPost(_,let param), .editPost(_,let param):
            return .body(param)
        case .getOnePost(_,let travelId):
            return .query(["travelId":travelId])
        }
    }
    
    var header: HeaderType {
        switch self {
        case .getAllPost, .getOnePost :
            return .basicHeader
        case .addPost, .scrapPost, .deletePost, .editPost, .getScrapedPost :
            return .withAuth
        }
    }
}
