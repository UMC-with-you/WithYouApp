import ProjectDescription

public extension Project {
    
    static func makeModule(
            name: String,
            platform: Platform = .iOS,
            product: Product,
            includeTest : Bool = false,
            organizationName: String = "withyou.org.",
            packages: [Package] = [],
            deploymentTarget: DeploymentTargets = .iOS("16.0"),
            dependencies: [TargetDependency] = [],
            sources: SourceFilesList = ["Sources/**"],
            resources: ResourceFileElements? = nil,
            infoPlist: InfoPlist = .default
        ) -> Project {
            var target = [Target.target(name: name,
                                destinations: .iOS,
                                product: product,
                                bundleId: "WithYou.app",
                                deploymentTargets: deploymentTarget,
                                 infoPlist: infoPlist,
                                sources: sources,
                                resources: resources,
                                 dependencies: dependencies)]
            
            if includeTest{
                let testTarget = Target.target(name: "\(name)Tests",
                                        destinations: .iOS,
                                        product: .unitTests,
                                        bundleId: "WithYou.app.Tests",
                                        deploymentTargets: deploymentTarget,
                                        infoPlist: .default,
                                        sources: "Tests/**",
                                        dependencies: [.target(name: name)]
                )
                target.append(testTarget)
            }
            
            return Project(
                name: name,
                organizationName: organizationName,
                packages: packages,
                targets: target
            )
        }
}
