//
//  Project.swift
//  Config
//
//  Created by 김도경 on 5/6/24.
//

import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeModule(
    name: "Domain",
    product: .staticFramework,
    dependencies: [
        .external(name: "RxSwift")
    ]
)
