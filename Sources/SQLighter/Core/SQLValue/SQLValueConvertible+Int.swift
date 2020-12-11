import Foundation

public extension SQLValueConvertible where Self: SignedInteger {
  var sqlValue: SQLValue { .int(.init(self)) }
  var sqlLiteral: String { description }
  
  init?(_ sqlValue: SQLValue) {
    if case let SQLValue.int(value) = sqlValue {
      self.init(value)
    } else {
      return nil
    }
  }
}

extension Int: SQLValueConvertible {}
extension Int8: SQLValueConvertible {}
extension Int16: SQLValueConvertible {}
extension Int32: SQLValueConvertible {}
extension Int64: SQLValueConvertible {}
