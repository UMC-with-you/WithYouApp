//
//  NoticeRouter.swift
//  Data
//
//  Created by 김도경 on 5/17/24.
//  Copyright © 2024 withyou.org. All rights reserved.
//

import Alamofire
import Domain
import Foundation

enum NoticeRouter {
    case createNotice(noticeDTO : CreateNoticeRequestDTO)
    case editNotice(noticeDTO : EditNoticeRequestDTO)
    case getOneNotice(noticeId : Int)
    case deleteNotice(noticeId : Int)
    case getAllNoticeByLog(travelId : Int)
    case checkNotice(noticeId: Int, memeberId : Int)
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
        case .getAllNoticeByLog, .getOneNotice : return .get
        case .checkNotice : return .patch
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
        case .checkNotice :
            return "/noticeCheck"
        }

    }
    
    var parameter: RequestParams {
        switch self {
        case .createNotice(let dto):
            return .body(dto)
        case .editNotice(let dto):
            return .body(dto)
        case .checkNotice(let noticeId, let memberId):
            let dic = [
                "noticeId" : noticeId,
                "memberId" : memberId
            ]
            return .query(dic)
        case .getOneNotice, .deleteNotice, .getAllNoticeByLog :
            return .none
        }
    }
    
    var header: HeaderType {
        .basicHeader
    }
}
