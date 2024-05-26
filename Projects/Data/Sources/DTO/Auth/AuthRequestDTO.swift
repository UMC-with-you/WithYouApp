//
//  AuthRequestDTO.swift
//  Data
//
//  Created by 김도경 on 5/17/24.
//  Copyright © 2024 withyou.org. All rights reserved.
//

import Foundation

public struct AuthRequestDTO : Encodable {
    var accessToken : String
    var provider : String
}
