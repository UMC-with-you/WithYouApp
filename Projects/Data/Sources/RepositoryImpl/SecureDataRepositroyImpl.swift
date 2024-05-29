//
//  SecureDataRepositroyImpl.swift
//  Data
//
//  Created by 김도경 on 5/25/24.
//  Copyright © 2024 withyou.org. All rights reserved.
//

import Domain
import RxSwift

public final class DefaultSecureDataRepository : SecureDataRepository {
    
    public init(){}
    
    public func saveToken(authToken: AuthToken) -> Single<Void> {
        return SecureDataManager.shared.saveToken(authToken: authToken)
    }
}
