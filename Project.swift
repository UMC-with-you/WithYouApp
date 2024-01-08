import ProjectDescription
import ProjectDescriptionHelpers

// Creates our project using a helper function defined in ProjectDescriptionHelpers
let target = Target(name: "WithYou", 
                    destinations: .iOS,
                    product: .app,
                    bundleId: "WithYou.app",
                    deploymentTargets: .iOS("15.0"), 
                    infoPlist: .file(path: "Support/Info.plist"),
                    sources: ["Sources/**"],
                    resources: ["Resources/**"],
                    dependencies: [
                        .package(product: "SnapKit", type: .runtime),
                        .package(product: "RxSwift", type: .runtime),
                        .package(product: "Alamofire", type: .runtime)
                    ]
)

let project = Project(name: "WithYou",
                      organizationName: "withyou.org.",
                      packages: [
                        .remote(url: "https://github.com/SnapKit/SnapKit", requirement: .upToNextMajor(from: "5.0.1")),
                        .remote(url: "https://github.com/ReactiveX/RxSwift.git", requirement: .upToNextMinor(from: "6.5.0")),
                        .remote(url: "https://github.com/Alamofire/Alamofire", requirement: .upToNextMajor(from: "5.0.0"))
                      ], targets: [target]
                      
)
