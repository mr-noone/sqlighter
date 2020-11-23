import Foundation

public extension SQLValueConvertible where Self == Bool {
  var sqlValue: SQLValue { .int(self ? 1 : 0) }
  var sqlLiteral: String { "\(self ? 1 : 0)" }
}

extension Bool: SQLValueConvertible {}
