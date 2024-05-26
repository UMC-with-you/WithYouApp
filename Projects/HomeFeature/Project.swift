//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by 김도경 on 5/7/24.
//

import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeModule(
    name: "HomeFeature", 
    product: .staticFramework,
    dependencies: [
        .project(target: "Domain", path: .relativeToRoot("Projects/Domain")),
        .project(target: "Data", path: .relativeToRoot("Projects/Data")),
        .external(name: "RxSwift"),
        .external(name: "SnapKit")
    ]
)
