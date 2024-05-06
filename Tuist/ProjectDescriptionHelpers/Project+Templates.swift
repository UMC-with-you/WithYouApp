import ProjectDescription

public extension Project {
    
    static func makeModule(
            name: String,
            platform: Platform = .iOS,
            product: Product,
            organizationName: String = "withyou.org.",
            packages: [Package] = [],
            deploymentTarget: DeploymentTargets = .iOS("16.0"),
            dependencies: [TargetDependency] = [],
            sources: SourceFilesList = ["Sources/**"],
            resources: ResourceFileElements? = nil,
            infoPlist: InfoPlist = .default
        ) -> Project {
            
            let target = Target(name: name,
                                destinations: .iOS,
                                product: product,
                                bundleId: "WithYou.app",
                                deploymentTargets: deploymentTarget,
                                sources: sources,
                                dependencies: dependencies
            )

            return Project(
                name: name,
                organizationName: organizationName,
                packages: packages,

                targets: [target]
            )
        }
}
