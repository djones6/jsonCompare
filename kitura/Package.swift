// swift-tools-version:4.0
import PackageDescription

let package = Package(
    name: "kitura",
    dependencies: [
      .package(url: "https://github.com/IBM-Swift/Kitura.git", .upToNextMinor(from: "2.0.0")),
      .package(url: "https://github.com/IBM-Swift/HeliumLogger.git", .upToNextMinor(from: "1.7.1")),
      .package(url: "https://github.com/IBM-Swift/CloudEnvironment.git", .upToNextMinor(from: "4.0.5")),
      .package(url: "https://github.com/IBM-Swift/Configuration.git", .upToNextMinor(from: "1.0.0")),
      .package(url: "https://github.com/IBM-Swift/Health.git", from: "0.0.0"),
      .package(url: "https://github.com/PerfectlySoft/Perfect.git", .upToNextMinor(from: "3.0.0"))
    ],
    targets: [
      .target(name: "kitura", dependencies: [ .target(name: "Application"), "Kitura" , "HeliumLogger"]),
      .target(name: "kituraOpt", dependencies: [ .target(name: "ApplicationOpt"), "Kitura" , "HeliumLogger"]),
      .target(name: "Application", dependencies: [ "Kitura", "Configuration", "CloudEnvironment","Health",      ]),
      .target(name: "ApplicationOpt", dependencies: [ "Kitura", "Configuration", "CloudEnvironment","Health", "PerfectLib"]),

      .testTarget(name: "ApplicationTests" , dependencies: [.target(name: "Application"), "Kitura","HeliumLogger" ])
    ]
)
