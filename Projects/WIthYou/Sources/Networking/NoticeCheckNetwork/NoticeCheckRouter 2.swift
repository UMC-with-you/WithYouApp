//
//  NoticeCheckRouter.swift
//  WithYou
//
//  Created by 김도경 on 2/11/24.
//  Copyright © 2024 withyou.org. All rights reserved.
//

import Alamofire
import Foundation

enum NoticeCheckRouter {
    case checkNotice(noticeId : Int, memberId : Int)
}

extension NoticeCheckRouter : BaseRouter {
    var baseURL: String {
        return Constants.baseURL
    }
    
    var method: HTTPMethod {
        return .patch
    }
    
    var path: String {
        return "/noticeCheck"
    }
    
    var parameter: RequestParams {
        switch self {
        case .checkNotice(let noticeId,let memberId):
            return .query([
                "noticeId": noticeId,
                "memberId" : memberId
            ])
        }
    }
    
    var header: HeaderType {
        return .basicHeader
    }
    
    
}
