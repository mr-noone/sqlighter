import Foundation

extension String: SQLTable, SQLColumn {
  public var sqlString: String { self }
}

extension String {
  func inserted(_ character: Character, offser: Int) -> String {
    var string = self
    let index = string.index(startIndex, offsetBy: offser)
    string.insert(character, at: index)
    return string
  }
  
  func inserted(_ substring: String, offser: Int) -> String {
    var string = self
    let index = string.index(startIndex, offsetBy: offser)
    string.insert(contentsOf: substring, at: index)
    return string
  }
}
