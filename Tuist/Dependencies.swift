//
//  Dependencies.swift
//  Config
//
//  Created by 김도경 on 5/6/24.
//

import ProjectDescription
import ProjectDescriptionHelpers


let dependencies = Dependencies(
    swiftPackageManager: .init(
        [
            .remote(url: "https://github.com/SnapKit/SnapKit", requirement: .upToNextMajor(from: "5.0.1")),
            .remote(url: "https://github.com/ReactiveX/RxSwift.git", requirement: .upToNextMinor(from: "6.7.1")),
            .remote(url: "https://github.com/Alamofire/Alamofire", requirement: .upToNextMajor(from: "5.9.1")),
            .remote(url: "https://github.com/RxSwiftCommunity/RxGesture.git", requirement: .upToNextMajor(from: "4.0.0")),
           .remote(url: "https://github.com/kakao/kakao-ios-sdk", requirement: .upToNextMinor(from: "2.11.1")),
//            .remote(url: "https://github.com/google/GoogleSignIn-iOS.git", requirement: .upToNextMajor(from: "7.1.0")),
            .remote(url: "https://github.com/onevcat/Kingfisher.git", requirement: .upToNextMajor(from: "7.11.0"))
        ]
    )
    ,platforms: [.iOS]
)
