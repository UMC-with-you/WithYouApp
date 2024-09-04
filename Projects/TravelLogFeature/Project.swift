//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by 김도경 on 5/31/24.
//

import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeModule(
    name: "TravelLogFeature",
    product: .staticFramework,
    dependencies: [
        .project(target: "Core", path: .relativeToRoot("Projects/Core")),
        .project(target: "Domain", path: .relativeToRoot("Projects/Domain")),
        .project(target: "CommonUI", path: .relativeToRoot("Projects/CommonUI")),
        .external(name: "RxSwift"),
        .external(name: "SnapKit")
    ]
)
