//
//  LogRouter.swift
//  WithYou
//
//  Created by 김도경 on 2/6/24.
//  Copyright © 2024 withyou.org. All rights reserved.
//

import Alamofire
import Foundation

enum LogRouter  {
    case getAllLog
    case addLog(log: Log)
    case deleteLog(travelId : Int)
    case editLog(travelId : Int)
    case joinLog(inviteCode : String)
    case getAllLogMemebers(travelId : Int)
    case getInviteCode(travelId : Int)
}

extension LogRouter : BaseRouter {
    var baseURL: String {
        return Constants.baseURL + "/travels"
    }
    
    var method: HTTPMethod {
        switch self{
        case .getAllLog, .getInviteCode, .getAllLogMemebers :
            return .get
        case .addLog : return .post
        case .deleteLog : return .delete
        case .editLog, .joinLog : return .patch
        }
    }
    
    var path: String {
        switch self{
        case .deleteLog(let travelId), .editLog(let travelId) :
            return "/\(travelId)"
        case .joinLog :
            return "/members"
        case .getAllLogMemebers(let travelId) :
            return "/\(travelId)/members"
        case .getInviteCode(let travelId):
            return "\(travelId)/invitation_code"
        default :
            return ""
        }
    }
    
    var parameter: RequestParams {
        switch self{
        case .getAllLog:
            return .query(["localDate" : dateController.dateToSendServer()])
        case .addLog(let log):
            return .body(log.asLogRequest())
        case .joinLog(let code):
            return .body(["invitationCode" : code])
        default :
            return .none
        }
    }
    
    var header: HeaderType {
        return .withAuth
    }
}
