import Foundation

public extension SQLValueConvertible where Self == Data {
  var sqlValue: SQLValue { .data(self) }
  var sqlLiteral: String { "X'\(self.hex)'" }
  
  init?(_ sqlValue: SQLValue) {
    if case let SQLValue.data(value) = sqlValue {
      self = value
    } else {
      return nil
    }
  }
}

extension Data: SQLValueConvertible {}
