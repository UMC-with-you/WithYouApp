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
    case uploadS3(url: String, image: Data)
    case downloadS3(url: String)
}

extension S3Router: BaseRouter {
    var baseURL: String {
        switch self {
        case .uploadS3(let url, _):
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
    
    var parameter: RequestParams {
        switch self {
            
        case .uploadS3(_ , let image):
            return .image(image)
        case .downloadS3:
            return .none
        }
    }
}
