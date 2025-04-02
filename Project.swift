import ProjectDescription

let project = Project(
    name: "WithYou",
    organizationName: "WithYou.app",
    targets: [
        .target(
            name: "WithYou",
            destinations: .iOS,
            product: .app,
            bundleId: "WithYou.app",
            deploymentTargets: .iOS("16.0"),
            infoPlist: .file(path: "Support/Info.plist"),
            sources: ["Sources/**"],
            resources: ["Resources/**"],
            dependencies: [
                .external(name: "Alamofire"),
                .external(name: "RxCocoa"),
                .external(name: "RxSwift"),
                .external(name: "RxGesture"),
                .external(name: "SnapKit"),
                .external(name: "KakaoSDK"),
//                                .external(name: "GoogleSignIn"),
                .external(name: "Kingfisher")
            ]
        )
    ]
)
