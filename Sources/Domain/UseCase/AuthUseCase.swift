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
    func authWithKakao(authCode : String) -> Single<Void>
    func authWithApple(accessToken : String,
                       userName : String,
                       email : String,
                       nonce : String) -> Single<Void>
    func authWithGoogle(authCode : String) -> Single<Void>
}

final public class DefaultAuthUseCase : AuthUseCase {
    
    let authRepository : AuthRepository
    let secureDataRepository : SecureDataRepository
    
    public init(repository: AuthRepository, secureDataRepository: SecureDataRepository) {
        self.authRepository = repository
        self.secureDataRepository = secureDataRepository
    }
    
    public func authWithKakao(authCode: String) -> Single<Void> {
        return Single<Void>.create { single in
            self.authRepository.authWithKakao(authCode: authCode).subscribe { authToken in
                self.saveToken(authToken).subscribe { _ in
                    single(.success(()))
                } onFailure: { error in
                    single(.failure(error))
                }
                .dispose()
            } onFailure: { error in
                single(.failure(error))
            }
        }
    }
    
    public func authWithApple(accessToken : String,
                              userName : String,
                              email : String,
                              nonce : String) -> Single<Void> {
        return Single<Void>.create { single in
            self.authRepository.authWithApple(accessToken: accessToken,
                                                             userName: userName,
                                                             email: email,
                                                             nonce: nonce)
            .subscribe { authToken in
                self.saveToken(authToken).subscribe { _ in
                    single(.success(()))
                } onFailure: { error in
                    single(.failure(error))
                }
                .dispose()
            } onFailure: { error in
                single(.failure(error))
            }
        }
    }
    
    public func authWithGoogle(authCode: String) -> Single<Void> {
        return Single<Void>.create { single in
            self.authRepository.authWithGoogle(authCode: authCode).subscribe { authToken in
                self.saveToken(authToken).subscribe { _ in
                    single(.success(()))
                } onFailure: { error in
                    single(.failure(error))
                }
                .dispose()
            } onFailure: { error in
                single(.failure(error))
            }
        }
    }
    
    public func saveToken(_ token : AuthToken) -> Single<Void> {
        secureDataRepository.saveToken(authToken: token)
    }
}
