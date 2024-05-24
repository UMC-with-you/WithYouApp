//
//  AuthRouter.swift
//  Data
//
//  Created by 김도경 on 5/17/24.
//  Copyright © 2024 withyou.org. All rights reserved.
//

import Alamofire
import Domain
import Foundation

enum AuthRouter {
    case kakao(authDTO : AuthRequestDTO)
    case apple(authDTO : AppleAuthRequestDTO)
    case google(authDTO : AuthRequestDTO)
}

extension AuthRouter : BaseRouter {
    
    var baseURL: String {
        Constants.baseURL
    }
    
    var method: HTTPMethod {
        .post
    }
    
    var path: String {
        "/auth"
    }
    
    var parameter: RequestParams {
        switch self {
        case .kakao(let dto):
            return .body(dto)
        case .apple(let dto):
            return .body(dto)
        case .google(let dto):
            return .body(dto)
        }
    }
    
    var header: HeaderType {
        .basicHeader
    }
}
