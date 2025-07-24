//
//  S3Router.swift
//  WithYou
//
//  Created by 이승진 on 5/22/25.
//  Copyright © 2025 WithYou.app. All rights reserved.
//

import Alamofire
import Foundation

public enum S3Router {
    case uploadS3(url: String)
    case downloadS3(url: String)
}

extension S3Router: BaseRouter {
    var parameter: RequestParams {
        .none
    }
    
    var baseURL: String {
        switch self {
        case .uploadS3(let url):
            return url
        case .downloadS3(let url):
            return url
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .uploadS3:
            return .put
        case .downloadS3:
            return .get
        }
    }
    
    var path: String {
        return ""
    }

    var header: HeaderType {
        return .image
    }
}
