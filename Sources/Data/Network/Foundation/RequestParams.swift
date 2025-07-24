//
//  RequestParams.swift
//  WithYou
//
//  Created by 김도경 on 2/5/24.
//  Copyright © 2024 withyou.org. All rights reserved.
//

import Foundation

enum RequestParams {
    case body(_ parameter: Encodable)
    case bodyFromDictionary(_ parameter : Dictionary<String, Any>)
    case query(_ parameter: Dictionary<String, Any>)
    case image(_ parameter: Data)
    case none
}
