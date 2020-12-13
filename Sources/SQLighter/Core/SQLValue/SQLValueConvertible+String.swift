import Foundation

public extension SQLValueConvertible where Self: StringProtocol {
  var sqlValue: SQLValue { .text(String(self)) }
  
  init?(_ sqlValue: SQLValue) {
    if case let SQLValue.text(value) = sqlValue {
      self.init(value)
    } else {
      return nil
    }
  }
}

extension String: SQLValueConvertible {}
