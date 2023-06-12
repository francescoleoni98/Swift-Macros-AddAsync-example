import SwiftSyntaxMacros
import SwiftSyntaxMacrosTestSupport
import XCTest
import TestMacroMacros

let testMacros: [String: Macro.Type] = [
  "AddAsync" : AddAsyncMacro.self
]

final class TestMacroTests: XCTestCase {
  func test() {
    assertMacroExpansion(
        """
        @AddAsync
        func test(arg1: String, completion: (String?) -> Void) {
          
        }
        """,
        expandedSource: """
        
        func test(arg1: String, completion: (String?) -> Void) {
          
        }
        
        func test(arg1: String) async -> String? {
          await withCheckedContinuation { continuation in
            self.test(arg1: arg1) { object in
              continuation.resume(returning: object)
            }
          }
        }
        """,
        macros: testMacros
    )
  }
}
