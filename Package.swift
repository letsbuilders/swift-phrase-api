// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "swift-phrase-api",
    platforms: [
        .macOS(.v10_15),
        .iOS(.v14)
    ],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "PhraseApi",
            targets: ["PhraseApi"]),
        .library(
            name: "PhraseApiVapor",
            targets: ["PhraseApiVapor"]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-log.git", from: "1.0.0"),
        .package(url: "https://github.com/swift-server/async-http-client.git", from: "1.6.0"),
        .package(url: "https://github.com/vapor/vapor.git", from: "4.0.0"),
    ],
    targets: [
        .target(
            name: "PhraseApi",
            dependencies: [
                .product(name: "Logging", package: "swift-log"),
                .product(name: "AsyncHTTPClient", package: "async-http-client"),
            ]),
        .target(
            name: "PhraseApiVapor",
            dependencies: [
                .target(name: "PhraseApi"),
                .product(name: "Vapor", package: "vapor")
            ]),
        .testTarget(
            name: "PhraseApiTests",
            dependencies: ["PhraseApi", "PhraseApiVapor"]),
    ]
)
