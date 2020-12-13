import Foundation

public extension SQLValueConvertible where Self: BinaryFloatingPoint {
  var sqlValue: SQLValue { .real(.init(self)) }
  
  init?(_ sqlValue: SQLValue) {
    if case let SQLValue.real(value) = sqlValue {
      self.init(value)
    } else {
      return nil
    }
  }
}

extension Float: SQLValueConvertible {}
extension Double: SQLValueConvertible {}
