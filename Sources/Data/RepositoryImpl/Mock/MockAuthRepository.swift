//
//  MockAuthRepository.swift
//  Data
//
//  Created by bryan on 2024/07/02.
//  Copyright © 2024 withyou.org. All rights reserved.
//

import Foundation
import RxSwift

public class MockAuthRepository : AuthRepository {
    
    public init(){}
    
    public func authWithKakao(authCode: String) -> Single<AuthToken> {
        .just(AuthToken(accessToken: "TestToken", refreshToken: "TestRefresh"))
    }
    
    public func authWithApple(accessToken: String, userName: String, email: String, nonce: String) -> Single<AuthToken> {
        .just(AuthToken(accessToken: "TestToken", refreshToken: "TestRefresh"))
    }
    
    public func authWithGoogle(authCode: String) -> Single<AuthToken> {
        .just(AuthToken(accessToken: "TestToken", refreshToken: "TestRefresh"))
    }
}
