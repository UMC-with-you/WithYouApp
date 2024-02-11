//
//  AuthModel.swift
//  WithYou
//
//  Created by 김도경 on 2/7/24.
//  Copyright © 2024 withyou.org. All rights reserved.
//

import Foundation

struct AuthModelRequest : Codable {
    var accessToken : String
    var provider : String
}

struct AuthModelResponse : Codable {
    var accessToken : String
    var refreshToken : String
}
