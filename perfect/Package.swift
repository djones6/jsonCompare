// swift-tools-version:4.0
import PackageDescription

let package = Package(
    name: "perfect",
    dependencies: [
      .package(url: "https://github.com/PerfectlySoft/Perfect-HTTPServer.git", .upToNextMinor(from: "3.0.0")),
    ],
    targets: [
      .target(name: "perfect", dependencies: [ "PerfectHTTPServer" ]),
    ]
)
