---
date: '2025-04-20T16:54:27+02:00'
draft: false
title: 'Using Tuist'
---

Xcode project files can be a pain to maintain and merge when working in a team. You can find several solutions to address this issue, such as [Xcodegen](https://yonaskolb.github.io/XcodeGen/Docs/Usage.html), or [Bazel](https://bazel.build). For Shoofler, I have decided to use [Tuist](https://tuist.dev).


Unlike Xcodegen which uses YAML or JSON configuration files, Tuist uses a Swift-based [Domain Specific Language](https://en.wikipedia.org/wiki/Domain-specific_language) to describe the project properties. Here is an excerpt of the `Project.swift` project description file, that configures the Shoofler app target:

```swift
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
                .automaticCodeSigning(
                	devTeam: Environment.shooflerDevTeamId.getString(default: ""))
                .codeSignIdentity("Apple Development")
                .merging(["ENABLE_HARDENED_RUNTIME": "YES"])
        )
    ),
]
```

Tuist offer a mechanism to check the syntaxic validity of your project files by simply compiling them. Once you're done with your configuration, just run `tuist generate`. The software will generate your Xcode project files, and will open the project. You never commit your .xcodeproj files to your sourcecode repository. I've setup tuist to manage both the Shoofler app and the shootool CLI automation tool.

There is obviously a downside to this system: it is sometimes difficult to find the right way to translate a setting you adjust in Xcode UI into code to place in your Tuist project files. Additionally, Tuist is evolving very fast, so it is not rare to find some instructions on the web that are already deprecated.