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
    case postRewind(rewindPostRequest: RewindPostRequest,travelId : Int)
    case getOneRewind(travelId : Int, rewindId : Int)
    case deleteRewind(travelId : Int, rewindId : Int)
    case editRewind(rewindPostRequest: RewindPostRequest,travelId : Int, rewindId : Int)
}

extension RewindRouter : BaseRouter {
    var baseURL: String {
        return Constants.baseURL
    }
    
    var method: HTTPMethod {
        switch self{
        case .getAllRewind, .getOneRewind:  return .get
        case .postRewind : return .post
        case .deleteRewind : return .delete
        case .editRewind : return .patch
        }
    }
    
    var path: String {
        switch self{
        case .getAllRewind(let id , _), .postRewind(_,let id):
            return "/\(id)/rewinds"
        case .deleteRewind(let travelId, let rewindId), .getOneRewind(let travelId, let rewindId), .editRewind(_,let travelId, let rewindId) :
            return "/\(travelId)/rewinds/\(rewindId)"
        }
    }
    
    var parameter: RequestParams {
        switch self{
        case .getAllRewind(_, let day):
            return .query(["day" : day ])
        case .postRewind(let rewindRequest, _), .editRewind(let rewindRequest, _,_):
            return .body(rewindRequest)
        case .getOneRewind, .deleteRewind:
            return .none
        }
    }
    
    var header: HeaderType {
        return .withAuth
    }
    
    
}
