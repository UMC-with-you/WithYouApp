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
    func authWithKakao(authCode : String) -> Single<AuthModelResponse>
    func authWithApple(authCode : String) -> Single<AuthModelResponse>
    func authWithGoogle(authCode : String) -> Single<AuthModelResponse>
}

final public class DefaultAuthUseCase : AuthUseCase {
    
    let repository : AuthRepository
    
    init(repository: AuthRepository) {
        self.repository = repository
    }
    
    public func authWithKakao(authCode: String) -> Single<AuthModelResponse> {
        repository.authWithKakao(authCode: authCode)
    }
    
    public func authWithApple(authCode: String) -> Single<AuthModelResponse> {
        repository.authWithApple(authCode: authCode)
    }
    
    public func authWithGoogle(authCode: String) -> Single<AuthModelResponse> {
        repository.authWithGoogle(authCode: authCode)
    }
}
