//
//  AuthResponseDTO.swift
//  Data
//
//  Created by 김도경 on 5/17/24.
//  Copyright © 2024 withyou.org. All rights reserved.
//

import Foundation

public struct AuthResponseDTO : Decodable {
    var accessToken : String
    var refreshToken : String
}

extension AuthResponseDTO {
    func toDomain() -> AuthToken {
        AuthToken(accessToken: self.accessToken, refreshToken: self.refreshToken)
    }
}
