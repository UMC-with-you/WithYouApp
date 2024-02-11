import ProjectDescription
import ProjectDescriptionHelpers

// Creates our project using a helper function defined in ProjectDescriptionHelpers
let target = Target(name: "WithYou", 
                    destinations: .iOS,
                    product: .app,
                    bundleId: "WithYou.app",
                    deploymentTargets: .iOS("16.0"),
                    infoPlist: .file(path: "Support/Info.plist"),
                    sources: ["Sources/**"],
                    resources: ["Resources/**"],
                    dependencies: [
                        .package(product: "Alamofire", type: .runtime),
                        .package(product: "RxSwift", type: .runtime),
                        .package(product: "RxCocoa",type: .runtime),
                        .package(product: "RxGesture", type: .runtime),
                        .package(product: "SnapKit", type: .runtime),
                        .package(product: "KakaoSDK", type: .runtime),
                        .package(product: "GoogleSignIn", type: .runtime)
                    ]
)

let project = Project(name: "WithYou",
                      organizationName: "withyou.org.",
                      packages: [
                        .remote(url: "https://github.com/SnapKit/SnapKit", requirement: .upToNextMajor(from: "5.0.1")),
                        .remote(url: "https://github.com/ReactiveX/RxSwift.git", requirement: .upToNextMinor(from: "6.5.0")),
                        .remote(url: "https://github.com/Alamofire/Alamofire", requirement: .upToNextMajor(from: "5.0.0")),
                        .remote(url: "https://github.com/RxSwiftCommunity/RxGesture.git", requirement: .upToNextMajor(from: "4.0.0")),
                        .remote(url: "https://github.com/kakao/kakao-ios-sdk", requirement: .upToNextMajor(from: "2.8.5")),
                        .remote(url: "https://github.com/google/GoogleSignIn-iOS.git", requirement: .upToNextMajor(from: "7.0.0"))
                      ], targets: [target]
                      
)
