//
//  NoticeRouter.swift
//  WithYou
//
//  Created by 김도경 on 2/7/24.
//  Copyright © 2024 withyou.org. All rights reserved.
//

import Alamofire
import Foundation

enum NoticeRouter {
    case createNotice(notice : Dictionary<String, Any>)
    case editNotice(notice : EditNoiceRequest)
    case getOneNotice(noticeId : Int)
    case deleteNotice(noticeId : Int)
    case getAllNoticeByLog(travelId : Int)
    case getAllNoticeByDate(travelId : Int)
}

extension NoticeRouter : BaseRouter {
    var baseURL: String {
        Constants.baseURL + "/notice"
    }
    
    var method: HTTPMethod {
        switch self{
        case .createNotice: return .post
        case .editNotice : return .patch
        case .deleteNotice : return .delete
        case .getAllNoticeByLog, .getOneNotice, .getAllNoticeByDate : return .get
        }
    }
    
    var path: String {
        switch self {
        case .createNotice, .editNotice : 
            return ""
        case .deleteNotice(let id), .getOneNotice(let id) :
            return "/\(id)"
        case .getAllNoticeByLog(let travelId) :
            return "/logs/\(travelId)"
        case .getAllNoticeByDate(let travelId) :
            return "/date/\(travelId)"
        }

    }
    
    var parameter: RequestParams {
        switch self {
        case .createNotice(let notice):
            return .bodyFromDictionary(notice)
        case .editNotice(let notice):
            return .body(notice)
        case .getOneNotice, .deleteNotice, .getAllNoticeByLog, .getAllNoticeByDate :
            return .none
        }
    }
    
    var header: HeaderType {
        .basicHeader
    }
}

