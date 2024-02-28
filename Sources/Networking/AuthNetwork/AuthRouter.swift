//
//  AuthRouter.swift
//  WithYou
//
//  Created by 김도경 on 2/7/24.
//  Copyright © 2024 withyou.org. All rights reserved.
//

import Alamofire
import Foundation


enum AuthRouter {
    case kakao(authCode : String)
    case apple(authCode : String, email: String, userName : String, nonce : String)
    case google(authCode : String)
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
        case .kakao(let code):
            return .body(AuthModelRequest(accessToken: code, provider: "kakao"))
        case .apple(let code, let email, let userName, let nonce):
            return .body(AppleAuthModel(accessToken: code, userName: userName, email: email, provider: "apple",nonce: nonce))
        case .google(let code):
            return .body(AuthModelRequest(accessToken: code, provider: "google"))
        }
    }
    
    var header: HeaderType {
        .basicHeader
    }
}
