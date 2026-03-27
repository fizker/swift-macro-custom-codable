import CustomCodableMacro
import Foundation
import Testing

struct Tests {
	@Test
	func jsonEncoding__defaultSettings__allPropertiesAreIncluded() async throws {
		let json = try encode(Basic(a: 1, b: "value"))

		#expect(json == """
		{
		  "a" : 1,
		  "b" : "value"
		}
		""")

		@CustomCodable
		struct Basic: Codable {
			var a: Int
			var b: String
		}
	}

	@Test
	func jsonEncoding__customName__propertyHasExpectedName() async throws {
		let json = try encode(WithRenamedProperty(a: 1, b: "value"))
		#expect(json == """
		{
		  "a" : 1,
		  "new-name" : "value"
		}
		""")

		@CustomCodable
		struct WithRenamedProperty: Codable {
			var a: Int
			@CodableKey(name: "new-name")
			var b: String
		}
	}

	@Test
	func jsonEncoding__ignoredProperty__propertyIsIgnored() async throws {
		let json = try encode(WithIgnoredProperty(a: 1, b: "value"))
		#expect(json == """
		{
		  "a" : 1
		}
		""")

		@CustomCodable
		struct WithIgnoredProperty: Codable {
			var a: Int
			@CodableKey(options: .ignore)
			var b: String?
		}
	}

	func encode(_ item: some Encodable) throws -> String {
		let encoder = JSONEncoder()
		encoder.outputFormatting = [ .prettyPrinted, .sortedKeys ]
		let data = try encoder.encode(item)
		return String(data: data, encoding: .utf8)!
	}
}
