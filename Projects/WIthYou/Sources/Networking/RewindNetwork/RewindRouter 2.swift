//
//  RewindRouter.swift
//  WithYou
//
//  Created by 김도경 on 2/6/24.
//  Copyright © 2024 withyou.org. All rights reserved.
//

import Alamofire
import Foundation

enum RewindRouter {
    case getAllRewind(travelId : Int, day : Int)
    case createRewind(rewindPostRequest: RewindPostRequest,travelId : Int)
    case getOneRewind(travelId : Int, rewindId : Int)
    case deleteRewind(travelId : Int, rewindId : Int)
    case editRewind(rewindPostRequest: RewindEditRequest,travelId : Int, rewindId : Int)
    case getQnaList
}

extension RewindRouter : BaseRouter {
    var baseURL: String {
        return Constants.baseURL
    }
    
    var method: HTTPMethod {
        switch self{
        case .getAllRewind, .getOneRewind, .getQnaList:  return .get
        case .createRewind : return .post
        case .deleteRewind : return .delete
        case .editRewind : return .patch
        }
    }
    
    var path: String {
        switch self{
        case .getAllRewind(let id , _), .createRewind(_,let id):
            return "/travels/\(id)/rewinds"
        case .deleteRewind(let travelId, let rewindId), .getOneRewind(let travelId, let rewindId), .editRewind(_,let travelId, let rewindId) :
            return "/travels/\(travelId)/rewinds/\(rewindId)"
        case .getQnaList:
            return "/rewindQuestions"
        }
    }
    
    var parameter: RequestParams {
        switch self{
        case .getAllRewind(_, let day):
            return .query(["day" : day ])
        case .createRewind(let rewindRequest, _):
            return .body(rewindRequest)
        case .editRewind(let rewindEditRequest, _, _):
            return .body(rewindEditRequest)
        case .getOneRewind, .deleteRewind, .getQnaList:
            return .none
        }
    }
    
    var header: HeaderType {
        return .withAuth
    }
}
