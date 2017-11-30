// swift-tools-version:4.0
import PackageDescription

let package = Package(
    name: "vapor",
    dependencies: [
      .package(url: "https://github.com/qutheory/vapor.git", .upToNextMinor(from: "2.0.0")),
    ],
    targets: [
      .target(name: "vapor", dependencies: [ "Vapor" ]),
    ]
)
