// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "UniversityDetails",
    
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "UniversityDetails",
            targets: ["UniversityDetails"]),
    ],
    dependencies: [
        .package(name: "NetworkKit", path: "../NetworkKit"),
        .package(name: "UIComponents", path: "../UIComponents")
    ],
    targets: [
        .target(
            name: "UniversityDetails",
            dependencies: ["NetworkKit",
                           "UIComponents"]),
    ]
)
