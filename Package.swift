// swift-tools-version: 6.2

import PackageDescription

let package = Package(
  name: "rada",
  platforms: [.macOS(.v26)],
  targets: [
    .executableTarget(name: "rada")
  ],
)
