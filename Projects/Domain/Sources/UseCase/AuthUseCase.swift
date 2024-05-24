//
//  AuthUseCase.swift
//  WithYou
//
//  Created by 김도경 on 5/5/24.
//  Copyright © 2024 withyou.org. All rights reserved.
//

import Foundation
import RxSwift

public protocol AuthUseCase {
    func authWithKakao(authCode : String) -> Single<AuthToken>
    func authWithApple(accessToken : String,
                       userName : String,
                       email : String,
                       provider : String,
                       nonce : String) -> Single<AuthToken>
    func authWithGoogle(authCode : String) -> Single<AuthToken>
}

final public class DefaultAuthUseCase : AuthUseCase {
    
    let repository : AuthRepository
    
    init(repository: AuthRepository) {
        self.repository = repository
    }
    
    public func authWithKakao(authCode: String) -> Single<AuthToken> {
        repository.authWithKakao(authCode: authCode)
    }
    
    public func authWithApple(accessToken : String,
                              userName : String,
                              email : String,
                              provider : String,
                              nonce : String) -> Single<AuthToken> {
        repository.authWithApple(accessToken: accessToken,
                                 userName: userName,
                                 email: email,
                                 provider: provider,
                                 nonce: nonce)
    }
    
    public func authWithGoogle(authCode: String) -> Single<AuthToken> {
        repository.authWithGoogle(authCode: authCode)
    }
}
