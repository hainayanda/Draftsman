// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Draftsman",
    platforms: [
        .iOS(.v11)
    ],
    products: [
        .library(
            name: "Draftsman",
            targets: ["Draftsman"]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/hainayanda/Clavier.git", from: "1.0.2"),
        .package(url: "https://github.com/Quick/Quick.git", from: "4.0.0"),
        .package(url: "https://github.com/Quick/Nimble.git", from: "9.2.0")
    ],
    targets: [
        .target(
            name: "Draftsman",
            dependencies: ["Clavier"],
            path: "Draftsman/Classes"
        ),
        .testTarget(
            name: "DraftsmanTests",
            dependencies: [
                "Draftsman", "Quick", "Nimble"
            ],
            path: "Example/Tests",
            exclude: ["Info.plist"]
        )
    ]
)
