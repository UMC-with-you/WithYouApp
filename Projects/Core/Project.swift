//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by 김도경 on 5/25/24.
//

import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeModule(
    name: "Core",
    product: .staticFramework,
    dependencies: [
        .external(name: "RxSwift"),
        .external(name: "SnapKit")
    ]
)
