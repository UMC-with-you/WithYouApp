//
//  SecureDataRepository.swift
//  Domain
//
//  Created by 김도경 on 5/25/24.
//  Copyright © 2024 withyou.org. All rights reserved.
//

import RxSwift

public protocol SecureDataRepository {
    func saveToken(authToken : AuthToken) -> Single<Void>
}
