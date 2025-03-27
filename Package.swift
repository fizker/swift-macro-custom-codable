// swift-tools-version: 6.0

import CompilerPluginSupport
import PackageDescription

let package = Package(
	name: "swift-macro-custom-codable",
	platforms: [
		.iOS(.v13),
		.macCatalyst(.v13),
		.macOS(.v10_15),
		.tvOS(.v13),
		.watchOS(.v6),
	],
	products: [
		.library(
			name: "CustomCodableMacro",
			targets: ["CustomCodableMacro"]
		),
	],
	dependencies: [
		.package(url: "https://github.com/swiftlang/swift-syntax.git", from: "600.0.1"),
	],
	targets: [
		.macro(
			name: "CustomCodableMacroImplementation",
			dependencies: [
				.product(name: "SwiftSyntax", package: "swift-syntax"),
				.product(name: "SwiftSyntaxMacros", package: "swift-syntax"),
				.product(name: "SwiftCompilerPlugin", package: "swift-syntax"),
			]
		),
		.target(
			name: "CustomCodableMacro",
			dependencies: [
				"CustomCodableMacroImplementation",
			]
		),
	]
)

#if !os(Windows)
// Note: This next comment is unverified, it was lifted from https://github.com/swiftlang/swift-syntax/blob/2da6a366aeb1d525bc654dec3e493acb60eeb4f3/Examples/Package.swift
// We can't write a test target for macros on Windows because that results in duplicate definitoions of `main`: Once
// from the macro (which is effectively an executable), and once from the test bundle.
package.targets.append(.testTarget(
	name: "CustomCodableMacroImplementationTests",
	dependencies: [
		"CustomCodableMacroImplementation",
		.product(name: "SwiftSyntaxMacros", package: "swift-syntax"),
		.product(name: "SwiftSyntaxMacrosTestSupport", package: "swift-syntax"),
	]
))
#endif
