// swift-tools-version: 5.9
import PackageDescription

#if TUIST
    import ProjectDescription

    let packageSettings = PackageSettings(
        // Customize the product types for specific package product
        // Default is .staticFramework
        // productTypes: ["Alamofire": .framework,] 
        productTypes: [
            "Alamofire": .framework, // default is .staticFramework
            "SnapKit": .framework,
            "KakaoSDKCommon": .framework,
            "Kingfisher": .framework,
            "RxCocoa": .framework,
            "RxCocoaRuntime" : .framework,
            "RxRelay" : .framework,
            "RxGesture": .framework,
            "AppAuth" : .framework
        ]
    )
#endif

let package = Package(
    name: "WithYou",
    dependencies: [
        .package(url: "https://github.com/SnapKit/SnapKit", .upToNextMajor(from:"5.0.1")),
        //.package(url: "https://github.com/ReactiveX/RxSwift.git",.upToNextMajor(from: "6.8.0")),
        .package(url:"https://github.com/google/GoogleSignIn-iOS", .upToNextMajor(from: "7.0.0")),
        .package(url: "https://github.com/Alamofire/Alamofire", .upToNextMajor(from:"5.9.1")),
        .package(url: "https://github.com/RxSwiftCommunity/RxGesture.git", .upToNextMajor(from:"4.0.0")),
        .package(url: "https://github.com/kakao/kakao-ios-sdk", .upToNextMajor(from: "2.24.0")),
        .package(url: "https://github.com/onevcat/Kingfisher.git", .upToNextMajor(from:"7.11.0"))
    ]
)
