// swift-tools-version: 5.10

import PackageDescription

var globalSwiftSettings: [PackageDescription.SwiftSetting] = [
    .enableExperimentalFeature("StrictConcurrency"),
    // Swift 6 enablement
    // .enableUpcomingFeature("StrictConcurrency")
    // .swiftLanguageVersion(.v5)
    .enableUpcomingFeature("ExistentialAny"),
    .enableExperimentalFeature("AccessLevelOnImport"),
    .enableUpcomingFeature("InternalImportsByDefault"),
]

let package = Package(
    name: "Heightmap",
    platforms: [
        .iOS(.v17),
        .macOS(.v14),
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
            dependencies: [
                .product(name: "Noise", package: "swift-noise"),
            ]
        ),
        .testTarget(
            name: "HeightmapTests",
            dependencies: [
                "Heightmap",
                .product(name: "Noise", package: "swift-noise"),
            ]
        ),
    ]
)
