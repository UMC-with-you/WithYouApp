import ProjectDescription

let project = Project(
    name: "WithYou",
    targets: [
        .target(
            name: "WithYou",
            destinations: .iOS,
            product: .app,
            bundleId: "WithYou.app",
            infoPlist: .file(path: "Support/Info.plist"),
            sources: ["Sources/**"],
            resources: ["Resources/**"],
            dependencies: [
                .external(name: "Alamofire"),
                .external(name: "RxSwift"),
                .external(name: "RxCocoa"),
                .external(name: "RxGesture"),
                .external(name: "SnapKit"),
                .external(name: "KakaoSDK"),
//                                .external(name: "GoogleSignIn"),
                .external(name: "Kingfisher")
            ]
        )
    ]
)
