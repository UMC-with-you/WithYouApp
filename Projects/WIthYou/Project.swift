import ProjectDescription
import ProjectDescriptionHelpers

// Creates our project using a helper function defined in ProjectDescriptionHelpers

let project = Project.makeModule(name: "WithYou",
                             product: .app,
                             dependencies: [
                                .project(target: "Domain", path: .relativeToRoot("Projects/Domain")),
                                .external(name: "Alamofire"),
                                .external(name: "RxSwift"),
                                .external(name: "RxCocoa"),
                                .external(name: "RxGesture"),
                                .external(name: "SnapKit"),
//                                .external(name: "KakaoSDK"),
//                                .external(name: "GoogleSignIn"),
                                .external(name: "Kingfisher")
                             ],
                             resources: ["Resources/**"],
                             infoPlist: .file(path: "Support/Info.plist")
)
