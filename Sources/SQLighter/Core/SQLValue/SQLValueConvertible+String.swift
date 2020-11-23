import Foundation

public extension SQLValueConvertible where Self: StringProtocol {
  var sqlValue: SQLValue { .text(String(self)) }
  var sqlLiteral: String { "'\(self)'" }
}

extension String: SQLValueConvertible {}
