//
//  S3Repository.swift
//  WithYou
//
//  Created by 이승진 on 5/22/25.
//  Copyright © 2025 WithYou.app. All rights reserved.
//

import Foundation
import RxSwift

public protocol S3Repository {
    func uploadS3(url: String, image: Data) -> Single<Void>
    func downloadS3(url: String) -> Single<Data>
}
