import ProjectDescription
import Foundation

let project = Project(
    name: "Shoofler",
    targets: [
        .target(
            name: "Shoofler",
            destinations: .macOS,
            product: .app,
            bundleId: "app.shoofler.Shoofler",
            infoPlist: .extendingDefault(with: [
                "CFBundleDisplayName": "$(PRODUCT_NAME)",
                "CFBundleName": "$(PRODUCT_NAME)",
                "CFBundleShortVersionString": "0.1.0",
                "CFBundleVersion": "1",
            ]),
            sources: ["Shoofler/Sources/**"],
            resources: ["Shoofler/Resources/**"],
            dependencies: [],
            settings: .settings(
                base: SettingsDictionary()
                    .automaticCodeSigning(devTeam: Environment.shooflerDevTeamId.getString(default: "")) // reads TUIST_SHOOFLER_DEV_TEAM_ID)
                    .codeSignIdentity("Apple Development")
                    .merging(["ENABLE_HARDENED_RUNTIME": "YES"])
            )
        ),
        .target(
            name: "ShooflerTests",
            destinations: .macOS,
            product: .unitTests,
            bundleId: "app.shoofler.ShooflerTests",
            infoPlist: .default,
            sources: ["Shoofler/Tests/**"],
            resources: [],
            dependencies: [.target(name: "Shoofler")]
        ),
    ]
)
