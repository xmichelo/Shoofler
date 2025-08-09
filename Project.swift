import ProjectDescription
import Foundation

let deploymentTargets = DeploymentTargets.macOS("15.0")

let project = Project(
    name: "Shoofler",
    settings: .settings(
        base: [
            "ENABLE_USER_SCRIPT_SANDBOXING": false,
            "ASSETCATALOG_COMPILER_GENERATE_SWIFT_ASSET_SYMBOL_EXTENSIONS": true,
            "SWIFT_VERSION": "6.0"
        ]
    ),
    targets: [
        .target(
            name: "Shoofler",
            destinations: .macOS,
            product: .app,
            bundleId: "app.shoofler.Shoofler",
            deploymentTargets: deploymentTargets,
            infoPlist: shooflerPList(),
            sources: ["Shoofler/Sources/**"],
            resources: ["Shoofler/Resources/**"],
            dependencies: [
                .external(name: "ComposableArchitecture"),
                .external(name: "CocoaLumberjack"),
                .external(name: "CocoaLumberjackSwift"),
            ],
            settings: .settings(
                base: SettingsDictionary().signing()
            )
        ),
        .target(
            name: "ShooflerTests",
            destinations: .macOS,
            product: .unitTests,
            bundleId: "app.shoofler.ShooflerTests",
            deploymentTargets: deploymentTargets,
            infoPlist: .default,
            sources: ["Shoofler/Tests/**"],
            resources: [],
            dependencies: [.target(name: "Shoofler")],
            settings: .settings(
                base: SettingsDictionary().signing()
            )
        ),
        .target(
            name: "shootool",
            destinations: .macOS,
            product: .commandLineTool,
            bundleId: "io.tuist.shootool",
            infoPlist: .default,
            sources: ["shootool/Sources/**"],
            resources: [],
            dependencies: [
                .external(name: "ArgumentParser")
            ]
        ),
    ]
)

extension Dictionary where Key == String, Value == ProjectDescription.SettingValue {
    public func signing() -> ProjectDescription.SettingsDictionary {
        let devTeam = Environment.shooflerDevTeamId.getString(default: "") // reads TUIST_SHOOFLER_DEV_TEAM_ID
        if devTeam.isEmpty {
            return self
        }
        
        return self
            .automaticCodeSigning(devTeam: devTeam)
            .codeSignIdentity("Apple Development")
            .merging(["ENABLE_HARDENED_RUNTIME": "YES"])
    }
}

func shooflerPList() -> InfoPlist {
    return InfoPlist.extendingDefault(
        with: [
            "CFBundleDisplayName": "$(PRODUCT_NAME)",
            "CFBundleName": "$(PRODUCT_NAME)",
            "CFBundleShortVersionString": "0.1.0",
            "CFBundleVersion": "10",
            "LSApplicationCategoryType": "public.app-category.productivity",
            "LSUIElement": true,
            "SMLoginItemRegistered": false,
            "UTExportedTypeDeclarations": [
                [
                    "UTTypeIdentifier": "app.shoofler.Snippet",
                    "UTTypeDescription": "Shoofler Snippet",
                    "UTTypeTagSpecification": [
                        "public.filename-extension": [".snippet"],
                        "public.mime-type": ["application/x-shoofler-snippet"]
                    ],
                    "UTTypeConformsTo": ["public.json"]
                ]
            ]
        ]
    )
}
