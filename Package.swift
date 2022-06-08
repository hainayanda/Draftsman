// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Draftsman",
    platforms: [
        .iOS(.v12)
    ],
    products: [
        .library(
            name: "Draftsman",
            targets: ["Draftsman"]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/hainayanda/Clavier.git", from: "2.0.1"),
        .package(url: "https://github.com/hainayanda/Builder.git", from: "1.0.4"),
        .package(url: "https://github.com/Quick/Quick.git", from: "5.0.1"),
        .package(url: "https://github.com/Quick/Nimble.git", from: "10.0.0")
    ],
    targets: [
        .target(
            name: "Draftsman",
            dependencies: ["Clavier", "Builder"],
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
