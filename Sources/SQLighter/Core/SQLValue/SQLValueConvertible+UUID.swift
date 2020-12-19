import Foundation

public extension SQLValueConvertible where Self == UUID {
  var sqlValue: SQLValue { .text(self.uuidString) }
  
  init?(_ sqlValue: SQLValue) {
    if case let SQLValue.text(value) = sqlValue {
      self.init(uuidString: value)
    } else {
      return nil
    }
  }
}

extension UUID: SQLValueConvertible {}
