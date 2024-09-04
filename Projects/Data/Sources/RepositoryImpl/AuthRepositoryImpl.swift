//
//  AuthRepositoryImpl.swift
//  Data
//
//  Created by 김도경 on 5/17/24.
//  Copyright © 2024 withyou.org. All rights reserved.
//

import Foundation
import Domain
import RxSwift

final public class DefaultAuthRepository : AuthRepository {
    
    private let service : BaseService = BaseService()
    
    public init(){}
    
    public func authWithKakao(authCode: String) -> Single<AuthToken> {
        let dto = AuthRequestDTO(accessToken: authCode, provider: "kakako")
        let router = AuthRouter.kakao(authDTO: dto)
        return service.request(AuthResponseDTO.self, router: router).map{ $0.toDomain() }
    }
    
    public func authWithApple(accessToken : String,
                              userName : String,
                              email : String,
                              nonce : String) -> Single<AuthToken> {
        let dto = AppleAuthRequestDTO(accessToken: accessToken,
                                      userName: userName,
                                      email: email,
                                      nonce: nonce)
        let router = AuthRouter.apple(authDTO: dto)
        return service.request(AuthResponseDTO.self, router: router).map{ $0.toDomain() }
    }
    
    public func authWithGoogle(authCode: String) -> Single<AuthToken> {
        let dto = AuthRequestDTO(accessToken: authCode, provider: "google")
        let router = AuthRouter.google(authDTO: dto)
        return service.request(AuthResponseDTO.self, router: router).map{ $0.toDomain() }
    }
}
