import Foundation

public extension SQLValueConvertible where Self: RawRepresentable, RawValue: SQLValueConvertible {
  var sqlValue: SQLValue { rawValue.sqlValue }
  
  init?(_ sqlValue: SQLValue) {
    if let value = RawValue(sqlValue) {
      self.init(rawValue: value)
    } else {
      return nil
    }
  }
}
