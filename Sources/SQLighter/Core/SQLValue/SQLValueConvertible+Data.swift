import Foundation

public extension SQLValueConvertible where Self == Data {
  var sqlValue: SQLValue { .data(self) }
  var sqlLiteral: String { "X'\(self.hex)'" }
}

extension Data: SQLValueConvertible {}
