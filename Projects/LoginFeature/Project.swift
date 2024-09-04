//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by 김도경 on 5/7/24.
//

import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeModule(
    name: "LoginFeature",
    product: .staticFramework,
    dependencies: [
        .project(target: "Domain", path: .relativeToRoot("Projects/Domain")),
        .project(target: "Core", path: .relativeToRoot("Projects/Core")),
        .external(name: "KakaoSDK"),
        .external(name: "RxSwift"),
        .external(name: "RxCocoa"),
        .external(name: "SnapKit")]
    )
