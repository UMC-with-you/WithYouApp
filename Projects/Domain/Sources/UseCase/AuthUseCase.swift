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
    
    func saveToken(accessToken : String, refreshToken : String) -> Single<Void>
}

final public class DefaultAuthUseCase : AuthUseCase {
    
    let authRepository : AuthRepository
    let secureDataRepository : SecureDataRepository
    
    init(repository: AuthRepository, secureDataRepository: SecureDataRepository) {
        self.authRepository = repository
        self.secureDataRepository = secureDataRepository
    }
    
    public func authWithKakao(authCode: String) -> Single<AuthToken> {
        authRepository.authWithKakao(authCode: authCode)
    }
    
    public func authWithApple(accessToken : String,
                              userName : String,
                              email : String,
                              provider : String,
                              nonce : String) -> Single<AuthToken> {
        authRepository.authWithApple(accessToken: accessToken,
                                 userName: userName,
                                 email: email,
                                 provider: provider,
                                 nonce: nonce)
    }
    
    public func authWithGoogle(authCode: String) -> Single<AuthToken> {
        authRepository.authWithGoogle(authCode: authCode)
    }
    
    public func saveToken(accessToken: String, refreshToken: String) -> RxSwift.Single<Void> {
        secureDataRepository.saveToken(authToken: AuthToken(accessToken: accessToken, refreshToken: refreshToken))
    }
}
