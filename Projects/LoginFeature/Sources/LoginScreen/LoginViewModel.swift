//
//  LoginViewModel.swift
//  LoginFeature
//
//  Created by 김도경 on 5/25/24.
//  Copyright © 2024 withyou.org. All rights reserved.
//

import AuthenticationServices
import CryptoKit
import Domain
import Foundation
import RxSwift

public class LoginViewModel {
    
    let authUseCase : AuthUseCase
    
    public init(authUseCase : AuthUseCase){
        self.authUseCase = authUseCase
    }
    
    func appleLogin(accessToken: String, userName: String, email: String, provider: String, nonce: String) -> Single<AuthToken>{
        authUseCase.authWithApple(accessToken: accessToken, userName: userName, email: email, provider: provider, nonce: nonce)
    }
    
    func kakaoLogin(authCode: String) -> Single<AuthToken> {
        authUseCase.authWithKakao(authCode: authCode)
    }
}


