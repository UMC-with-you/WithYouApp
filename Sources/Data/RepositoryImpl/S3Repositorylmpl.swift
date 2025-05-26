//
//  S3Repositorylmpl.swift
//  WithYou
//
//  Created by 이승진 on 5/22/25.
//  Copyright © 2025 WithYou.app. All rights reserved.
//

import Foundation
import RxSwift

final public class DefaultS3Repository: S3Repository {
    
    private let service: BaseService = BaseService()
    
    public init() {}
    
    public func uploadS3(url: String, image: Data) -> Single<Void> {
        let router = S3Router.uploadS3(url: url)
        return service.uploadToS3(router: router, image: image)
    }
    
    public func downloadS3(url: String) -> Single<Data> {
        let router = S3Router.downloadS3(url: url)
        return service.downloadS3(router: router)
    }
}
