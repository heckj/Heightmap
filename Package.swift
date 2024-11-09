// swift-tools-version: 5.8
// Swift 5.9 to support Xcode 15.2 on GitHub Actions
// Swift 5.10 requires Xcode 15.4 in GitHub Actions

import PackageDescription

var globalSwiftSettings: [PackageDescription.SwiftSetting] = [
    .enableExperimentalFeature("StrictConcurrency"),
    .enableUpcomingFeature("ExistentialAny"),
    .enableExperimentalFeature("AccessLevelOnImport"),
    .enableUpcomingFeature("InternalImportsByDefault"),
]

let package = Package(
    name: "Heightmap",
    platforms: [
        .iOS(.v16),
        .macOS(.v13),
    ],
    products: [
        .library(
            name: "Heightmap",
            targets: ["Heightmap"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/tayloraswift/swift-noise", from: "1.1.0"),
    ],
    targets: [
        .target(
            name: "Heightmap",
            dependencies: [],
            swiftSettings: globalSwiftSettings
        ),
        .testTarget(
            name: "HeightmapTests",
            dependencies: [
                "Heightmap",
            ],
            swiftSettings: globalSwiftSettings
        ),
    ]
)
