// swift-tools-version: 6.2

import PackageDescription

let package = Package(
  name: "rada",
  platforms: [.macOS(.v26)],
  dependencies: [
    .package(
      url: "https://github.com/apple/swift-argument-parser",
      from: "1.7.1"
    )
  ],
  targets: [
    .executableTarget(
      name: "rada",
      dependencies: [
        .product(
          name: "ArgumentParser",
          package: "swift-argument-parser"
        )
      ]
    )
  ]
)
