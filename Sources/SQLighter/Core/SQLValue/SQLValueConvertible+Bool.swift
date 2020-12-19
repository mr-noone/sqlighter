import Foundation

public extension SQLValueConvertible where Self == Bool {
  var sqlValue: SQLValue { .int(self ? 1 : 0) }
  
  init?(_ sqlValue: SQLValue) {
    if case let SQLValue.int(value) = sqlValue, 0...1 ~= value {
      self = value == 1
    } else {
      return nil
    }
  }
}

extension Bool: SQLValueConvertible {}
