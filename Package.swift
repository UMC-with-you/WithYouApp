// swift-tools-version: 5.9
import PackageDescription

#if TUIST
    import ProjectDescription
    import ProjectDescriptionHelpers

    let packageSettings = PackageSettings(
        productTypes: [
            "Alamofire": .framework, // default is .staticFramework
            "SnapKit": .framework,
                    "RxSwift": .framework,
                    "RxGesture": .framework,
                    "KakaoSDKCommon": .framework,
                    "Kingfisher": .framework
        ]
    )

#endif

let package = Package(
    name: "PackageName",
    dependencies: [
        .package(url: "https://github.com/SnapKit/SnapKit", from: "5.0.1"),
        .package(url: "https://github.com/ReactiveX/RxSwift.git", from: "6.7.1"),
        .package(url: "https://github.com/Alamofire/Alamofire", from: "5.9.1"),
        .package(url: "https://github.com/RxSwiftCommunity/RxGesture.git", from: "4.0.0"),
        .package(url: "https://github.com/kakao/kakao-ios-sdk", from: "2.11.1"),
        .package(url: "https://github.com/onevcat/Kingfisher.git", from: "7.11.0")

    ]
)
