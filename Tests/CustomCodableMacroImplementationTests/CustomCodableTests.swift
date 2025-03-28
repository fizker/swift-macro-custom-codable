//===----------------------------------------------------------------------===//
//
// This source file was originally part of the Swift.org open source project
//
// The original can be found at https://github.com/swiftlang/swift-syntax/blob/2da6a366aeb1d525bc654dec3e493acb60eeb4f3/Examples/Tests/MacroExamples/Implementation/Member/CustomCodableTests.swift
//
// Copyright (c) 2014 - 2023 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://swift.org/LICENSE.txt for license information
// See https://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
//
//===----------------------------------------------------------------------===//

import CustomCodableMacroImplementation
import SwiftSyntaxMacros
import SwiftSyntaxMacrosTestSupport
import XCTest

final class CustomCodableTests: XCTestCase {
  private let macros = ["CustomCodable": CustomCodable.self]

  func testExpansionAddsDefaultCodingKeys() {
    assertMacroExpansion(
      """
      @CustomCodable
      struct Person {
        let name: String
        let age: Int
      }
      """,
      expandedSource: """
        struct Person {
          let name: String
          let age: Int

          enum CodingKeys: String, CodingKey {
            case name
            case age
          }
        }
        """,
      macros: macros,
      indentationWidth: .spaces(2)
    )
  }

  func testExpansionWithCodableKeyAddsCustomCodingKeys() {
    assertMacroExpansion(
      """
      @CustomCodable
      struct Person {
        let name: String
        @CodableKey("user_age") let age: Int

        func randomFunction() {}
      }
      """,
      expandedSource: """
        struct Person {
          let name: String
          @CodableKey("user_age") let age: Int

          func randomFunction() {}

          enum CodingKeys: String, CodingKey {
            case name
            case age = "user_age"
          }
        }
        """,
      macros: macros,
      indentationWidth: .spaces(2)
    )
  }
}
