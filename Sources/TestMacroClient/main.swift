import TestMacro

//@Initiated
//class ServerError {
//  
//  var id: String
//  let new: Int
//}

//@AddAsync
struct AsyncFunctions {
  
  @AddAsync
  func test(arg1: String, completion: (String) -> Void) {
    
  }
}

func testing() async {
  let result = await AsyncFunctions().test(arg1: "Blob")
}
