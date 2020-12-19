import Foundation

public extension SQLValueConvertible where Self: UnsignedInteger {
  var sqlValue: SQLValue { .int(.init(self)) }
  
  init?(_ sqlValue: SQLValue) {
    if case let SQLValue.int(value) = sqlValue {
      self.init(value)
    } else {
      return nil
    }
  }
}

extension UInt: SQLValueConvertible {}
extension UInt8: SQLValueConvertible {}
extension UInt16: SQLValueConvertible {}
extension UInt32: SQLValueConvertible {}
extension UInt64: SQLValueConvertible {}
