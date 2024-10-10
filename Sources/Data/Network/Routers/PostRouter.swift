//
//  PostRouter.swift
//  Data
//
//  Created by 김도경 on 5/24/24.
//  Copyright © 2024 withyou.org. All rights reserved.
//

import Alamofire
import Foundation

enum PostRouter {
    case getAllPost(travelId : Int)
    case addPost(postDTO : AddPostRequestDTO, travelId : Int)
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
        case .getAllPost(let travelId), .addPost(_, let travelId):
            return "/\(travelId)/posts"
        case .getOnePost(let postId,_), .scrapPost(let postId), .deletePost(let postId), .editPost(let postId,_):
            return "/\(postId)"
        case .getScrapedPost:
            return ""
        }
    }
    
    var parameter: RequestParams {
        switch self {
        case .getOnePost(_,let travelId):
            return .query(["travelId":travelId])
        case .editPost(_, let editContent):
            return .body(editContent)
        default:
            return .none
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
    
    var multipart: MultipartFormData{
        switch self {
        case .addPost(let dto, _):
            let multiPart = MultipartFormData(boundary:"<calculated when request is sent>")
            let dic = [
                "text" : dto.text
            ]
            var text = "\(dic)"
            text = text.replacingOccurrences(of: "[", with: "{")
            text = text.replacingOccurrences(of: "]", with: "}")
            
            for (index, image) in dto.images.enumerated() {
                multiPart.append(image, withName: "mediaList", fileName: "Post\(index).jpeg", mimeType: "image/jpeg")
            }

            multiPart.append(text.data(using: .utf8)!, withName: "request", mimeType: "application/json")
            
            return multiPart
        default:
            return MultipartFormData()
        }
    }
}

