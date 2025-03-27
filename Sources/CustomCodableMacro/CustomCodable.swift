//===----------------------------------------------------------------------===//
//
// This source file was originally part of the Swift.org open source project
//
// The original can be found at https://github.com/swiftlang/swift-syntax/blob/2da6a366aeb1d525bc654dec3e493acb60eeb4f3/Examples/Sources/MacroExamples/Interface/MemberMacros.swift
//
// Copyright (c) 2014 - 2023 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://swift.org/LICENSE.txt for license information
// See https://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
//
//===----------------------------------------------------------------------===//

// MARK: - Custom Codable

@attached(member, names: named(CodingKeys))
public macro CustomCodable() = #externalMacro(module: "CustomCodableMacroImplementation", type: "CustomCodable")

@attached(peer)
public macro CodableKey(name: String) = #externalMacro(module: "CustomCodableMacroImplementation", type: "CodableKey")
