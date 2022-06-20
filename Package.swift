// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
	name: "AstraMediaLibrary",
	platforms: [
		.iOS(.v15)
	],
	products: [
		.library(
			name: "AstraMediaLibrary",
			targets: ["AstraMediaLibrary"]
		),
	],
	dependencies: [
		.package(
			url: "https://github.com/kyuuuyki/AstraCoreModels.git",
			branch: "main"
		),
		.package(
			url: "https://github.com/SDWebImage/SDWebImage.git",
			from: "5.1.0"
		),
	],
	targets: [
		.target(
			name: "AstraMediaLibrary",
			dependencies: [
				"AstraCoreModels",
				"SDWebImage",
			],
			resources: [
				.process("Resources/Assets.xcassets"),
			]
		),
		.testTarget(
			name: "AstraMediaLibraryTests",
			dependencies: ["AstraMediaLibrary"]
		),
	]
)
