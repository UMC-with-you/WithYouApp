//
//  RewindRouter.swift
//  Data
//
//  Created by 김도경 on 5/24/24.
//  Copyright © 2024 withyou.org. All rights reserved.
//

import Alamofire
import Foundation

enum RewindRouter {
    case getAllRewind(travelId : Int, day : Int)
    case createRewind(rewindDTO: CreateRewindRequestDTO, travelId : Int)
    case getOneRewind(travelId : Int, rewindId : Int)
    case deleteRewind(travelId : Int, rewindId : Int)
    case editRewind(rewindDTO : EditRewindRequestDTO, travelId : Int, rewindId : Int)
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
            return .query(["day" : day])
        case .createRewind(let dto, _):
            return .body(dto)
        case .editRewind(let dto, _, _):
            return .body(dto)
        case .getOneRewind, .deleteRewind, .getQnaList:
            return .none
        }
    }
    
    var header: HeaderType {
        return .withAuth
    }
}

