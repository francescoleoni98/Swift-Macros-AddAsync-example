// The Swift Programming Language
// https://docs.swift.org/swift-book

/// A macro that produces an async funtion from a completion function.
///
@attached(peer, names: overloaded)
public macro AddAsync() = #externalMacro(module: "TestMacroMacros", type: "AddAsyncMacro")
