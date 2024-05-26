//
//  AuthRepository.swift
//  WithYou
//
//  Created by 김도경 on 5/5/24.
//  Copyright © 2024 withyou.org. All rights reserved.
//

import Foundation
import RxSwift

public protocol AuthRepository {
    func authWithKakao(authCode : String) -> Single<AuthToken>
    func authWithApple(accessToken : String,
                       userName : String,
                       email : String,
                       provider : String,
                       nonce : String) -> Single<AuthToken>
    func authWithGoogle(authCode : String) -> Single<AuthToken>
}
