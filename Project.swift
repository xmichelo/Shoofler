import ProjectDescription

let project = Project(
    name: "Shoofler",
    targets: [
        .target(
            name: "Shoofler",
            destinations: .macOS,
            product: .app,
            bundleId: "io.tuist.Shoofler",
            infoPlist: .default,
            sources: ["Shoofler/Sources/**"],
            resources: ["Shoofler/Resources/**"],
            dependencies: []
        ),
        .target(
            name: "ShooflerTests",
            destinations: .macOS,
            product: .unitTests,
            bundleId: "io.tuist.ShooflerTests",
            infoPlist: .default,
            sources: ["Shoofler/Tests/**"],
            resources: [],
            dependencies: [.target(name: "Shoofler")]
        ),
    ]
)
