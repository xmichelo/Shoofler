import ProjectDescription
import Foundation

let project = Project(
    name: "Shoofler",
    settings: .settings(
        base: [
            "ENABLE_USER_SCRIPT_SANDBOXING": true,
            "ASSETCATALOG_COMPILER_GENERATE_SWIFT_ASSET_SYMBOL_EXTENSIONS": true,
        ]
    ),
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
                "CFBundleVersion": "3",
                "LSApplicationCategoryType": "public.app-category.productivity",
            ]),
            sources: ["Shoofler/Sources/**"],
            resources: ["Shoofler/Resources/**"],
            dependencies: [],
            settings: .settings(
                base: SettingsDictionary().signing()
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
    ///
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

