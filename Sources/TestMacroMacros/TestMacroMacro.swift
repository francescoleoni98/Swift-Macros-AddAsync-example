import SwiftCompilerPlugin
import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros
import Foundation

enum AsyncError: Error, CustomStringConvertible {
  
  case onlyFunction
  
  var description: String {
    switch self {
    case .onlyFunction:
      return "@AddAsync can be attached only to functions."
    }
  }
}

public struct AddAsyncMacro: PeerMacro {
  
  public static func expansion(of node: AttributeSyntax, providingPeersOf declaration: some DeclSyntaxProtocol, in context: some MacroExpansionContext) throws -> [DeclSyntax] {
    guard let functionDecl = declaration.as(FunctionDeclSyntax.self) else {
      throw AsyncError.onlyFunction
    }
    
    if let signature = functionDecl.signature.as(FunctionSignatureSyntax.self) {
      let parameters = signature.input.parameterList
      
      if let completion = parameters.last,
         let completionType = completion.type.as(FunctionTypeSyntax.self)?.arguments.first,
         let remainPara = FunctionParameterListSyntax(parameters.removingLast()) {
        
        let functionArgs = remainPara.map { parameter -> String in
          guard let paraType = parameter.type.as(SimpleTypeIdentifierSyntax.self)?.name else { return "" }
          return "\(parameter.firstName): \(paraType)"
        }.joined(separator: ", ")
        
        let calledArgs = remainPara.map { "\($0.firstName): \($0.firstName)" }.joined(separator: ", ")
        
        return [
          """
          
          
          func \(functionDecl.identifier)(\(raw: functionArgs)) async -> \(completionType) {
            await withCheckedContinuation { continuation in
              self.\(functionDecl.identifier)(\(raw: calledArgs)) { object in
                continuation.resume(returning: object)
              }
            }
          }
          """
        ]
      }
    }
    
    return []
  }
}

@main
struct TestMacroPlugin: CompilerPlugin {
  let providingMacros: [SwiftSyntaxMacros.Macro.Type] = [
    AddAsyncMacro.self
  ]
}
