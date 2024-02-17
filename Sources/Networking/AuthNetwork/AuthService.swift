//
//  AuthService.swift
//  WithYou
//
//  Created by 김도경 on 2/7/24.
//  Copyright © 2024 withyou.org. All rights reserved.
//

import Foundation


class AuthService : BaseService {
    static let shared = AuthService()
    override private init(){}
    
    func authWithKakao(_ authCode : String, _ completion : @escaping (AuthModelResponse)-> Void){
        authRequest( router: AuthRouter.kakao(authCode: authCode), completion: completion)
    }
    
    func authWithApple(_ authCode : String, userName : String, email : String, _ completion : @escaping (AuthModelResponse)-> Void){
        authRequest( router: AuthRouter.apple(authCode: authCode, email: email, userName: userName), completion: completion)
    }
    
    func authWithGoogle(_ authCode : String, _ completion : @escaping (AuthModelResponse)-> Void){
        authRequest( router: AuthRouter.google(authCode: authCode), completion: completion)
    }
}
