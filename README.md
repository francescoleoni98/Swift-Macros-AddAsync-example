# Swift Macros - AddAsync example
In this example Swift Macaros are used to add an async function to a completion function like `func test(arg1: String, completion: (String) -> Void)` using the `@AddAsync` macro.  

```swift
@AddAsync
func test(arg1: String, completion: (String) -> Void) {
    
}

// Macro generated async function
func test(arg1: String) async -> String {
   await withCheckedContinuation { continuation in
      self.test(arg1: String) { object in
         continuation.resume(returning: object)
      }
   }
}
```

## What are Macros?
Swift Macros allow you to generate repetitive code at compile time, making your app's codebase more easier to read and less tedious to write.

 
For more info about SwiftMacro check out [this article](https://blog.leonifrancesco.com/articles/swift-macros).
