// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "AppSyncRealTimeClient",
    products: [
        .library(
            name: "AppSyncRealTimeClient",
            targets: ["AppSyncRealTimeClient"]),
    ],
    dependencies: [
        .package(url: "https://github.com/daltoniam/Starscream", .branch("master"))
    ],
    targets: [
        .target(
            name: "AppSyncRealTimeClient",
            dependencies: ["Starscream"],
            path: "AppSyncRealTimeClient",
            exclude: ["Info.plist"]
        ),
        .testTarget(
            name: "AppSyncRealTimeClientTests",
            dependencies: ["AppSyncRealTimeClient"],
            path: "AppSyncRealTimeClientTests",
            exclude: ["Info.plist"]
        )
    ]
)
