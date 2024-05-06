//
//  AuthRepository.swift
//  WithYou
//
//  Created by 김도경 on 5/5/24.
//  Copyright © 2024 withyou.org. All rights reserved.
//

import Foundation
import RxSwift

protocol AuthRepository {
    func authWithKakao(authCode : String) -> Single<AuthModelResponse>
    func authWithApple(authCode : String) -> Single<AuthModelResponse>
    func authWithGoogle(authCode : String) -> Single<AuthModelResponse>
}
