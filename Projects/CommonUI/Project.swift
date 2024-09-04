//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by 김도경 on 5/26/24.
//

import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeModule(name: "CommonUI",
                             product: .staticFramework,
                             dependencies: [
                                .project(target: "Domain", path: .relativeToRoot("Projects/Domain")),
                                .project(target: "Core", path: .relativeToRoot("Projects/Core")),
                                .external(name: "Kingfisher"),
                                .external(name: "RxGesture")
                             ],
                                 resources: ["Resources/**"]
)
