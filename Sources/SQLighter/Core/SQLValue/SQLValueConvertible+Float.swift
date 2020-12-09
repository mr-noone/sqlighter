import Foundation

public extension SQLValueConvertible where Self: BinaryFloatingPoint {
  var sqlValue: SQLValue { .real(.init(self)) }
  var sqlLiteral: String { "\(self)" }
}

extension Float: SQLValueConvertible {}
extension Double: SQLValueConvertible {}
