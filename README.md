# Swift Macros - AddAsync example
## What are Macros?
Swift Macros allow you to generate repetitive code at compile time, making your app's codebase more easier to read and less tedious to write.

There are two types of macros: 
* **Freestanding** macros stand in place of something else in your code. They always start with a **hashtag** (#) sign. 
```swift
#caseDetection // Freestanding Macro
```
* **Attached** macros are used as attributes on declarations in your code. They start with an **@** sign.
```swift
@CaseDetection // Attached Macro
```
