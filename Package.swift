// swift-tools-version:5.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SDL2Test",
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        .package(url: "../CSDL2", from: "0.0.1"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages which this package depends on.
        .target(
            name: "SDL2Test",
            dependencies: []),
        .testTarget(
            name: "SDL2TestTests",
            dependencies: ["SDL2Test"]),
    ]
)
