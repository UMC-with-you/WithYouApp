//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by 김도경 on 5/26/24.
//

import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeModule(name: "App",
                             product: .app,
                             dependencies: [
                                .project(target: "Domain", path: .relativeToRoot("Projects/Domain")),
                                .project(target: "Core", path: .relativeToRoot("Projects/Core")),
                                .project(target: "Data", path: .relativeToRoot("Projects/Data")),
                                .project(target: "HomeFeature", path: .relativeToRoot("Projects/HomeFeature")),
                                .project(target: "LoginFeature", path: .relativeToRoot("Projects/LoginFeature")),
                                .project(target: "TravelLogFeature", path: .relativeToRoot("Projects/TravelLogFeature")),
                                .project(target: "CreateLogFeature", path: .relativeToRoot("Projects/CreateLogFeature")),
                                .project(target: "MyPageFeature", path: .relativeToRoot("Projects/MyPageFeature"))
                             ],
                                 resources: ["Resources/**"],
                             infoPlist: .file(path: "Support/Info.plist")
)
