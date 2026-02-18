// swift-tools-version: 5.7
import PackageDescription

let package = Package(
    name: "SharkordIOS",
    platforms: [
        .iOS(.v15)
    ],
    products: [
        .library(
            name: "SharkordIOS",
            targets: ["SharkordIOS"]
        )
    ],
    dependencies: [],
    targets: [
        .target(
            name: "SharkordIOS",
            dependencies: []
        )
    ]
)
