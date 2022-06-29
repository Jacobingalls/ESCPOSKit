// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ECSPOS",
    platforms: [
        .macOS(.v12)
    ],
    products: [
        .executable(name: "ESCPOS-Example", targets: ["ESCPOS-Example"]),
        .library(name: "ESCPOS", targets: ["ESCPOS"])
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
    ],
    targets: [
        .target(name: "Cescpos", publicHeadersPath: "."),
        .target(
            name: "ESCPOS",
            dependencies: [
                .byName(name: "Cescpos")
            ]),
        .executableTarget(
            name: "ESCPOS-Example",
            dependencies: [
                .byName(name: "ESCPOS")
            ]),
        .testTarget(
            name: "ESCPOSTests",
            dependencies: ["ESCPOS"]),
    ]
)
