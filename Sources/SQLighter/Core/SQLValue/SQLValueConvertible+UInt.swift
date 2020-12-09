import Foundation

public extension SQLValueConvertible where Self: UnsignedInteger {
  var sqlValue: SQLValue { .int(.init(self)) }
  var sqlLiteral: String { description }
}

extension UInt: SQLValueConvertible {}
extension UInt8: SQLValueConvertible {}
extension UInt16: SQLValueConvertible {}
extension UInt32: SQLValueConvertible {}
extension UInt64: SQLValueConvertible {}
