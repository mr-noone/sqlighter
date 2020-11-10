// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SQLighter",
    products: [
        .library(name: "SQLighter", targets: ["SQLighter"]),
    ],
    dependencies: [],
    targets: [
        .target(name: "SQLighter", dependencies: [])
    ]
)
