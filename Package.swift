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
        .package(url: "https://github.com/hainayanda/Clavier.git", from: "1.0.3"),
        .package(url: "https://github.com/hainayanda/Builder.git", from: "1.0.3"),
        .package(url: "https://github.com/Quick/Quick.git", from: "4.0.0"),
        .package(url: "https://github.com/Quick/Nimble.git", from: "9.2.1")
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
