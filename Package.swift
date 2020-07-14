// swift-tools-version:5.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SwiftSDL2",
    products: [
        // Products define the executables and libraries produced by a package, and make them visible to other packages.
        .library(
            name: "SwiftSDL2",
            targets: ["SwiftSDL2"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        .package(url: "https://github.com/drmidnight/CSDL2.git", from: "0.0.11"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages which this package depends on.
        .target(
            name: "SwiftSDL2",
            dependencies: ["CSDL2"],
                    linkerSettings: [
                    .unsafeFlags(["-L", "/usr/local/Cellar/sdl2/2.0.12_1/lib/"], .when(platforms: [.macOS])),
                    .unsafeFlags(["-L", "/usr/local/Cellar/sdl2_image/2.0.5/lib/"], .when(platforms: [.macOS])),
                    .unsafeFlags(["-L", "/usr/local/Cellar/sdl2_ttf/2.0.15/lib/"], .when(platforms: [.macOS])),
                    ]),
    ]
  
)
