//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by 김도경 on 5/6/24.
//

import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeModule(
    name: "Data", 
    product: .staticFramework,
    includeTest: true,
    dependencies: [
        .project(target: "Domain", path: .relativeToRoot("Projects/Domain")),
        .external(name: "Alamofire"),
        .external(name: "RxSwift")
    ]
)
