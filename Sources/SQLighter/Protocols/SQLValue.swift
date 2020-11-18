import Foundation

public protocol SQLValue {
  var string: String { get }
}

public extension SQLValue where Self: SignedInteger {
  var string: String { description }
}

extension Int: SQLValue {}
extension Int8: SQLValue {}
extension Int16: SQLValue {}
extension Int32: SQLValue {}
extension Int64: SQLValue {}

public extension SQLValue where Self: UnsignedInteger {
  var string: String { description }
}

extension UInt: SQLValue {}
extension UInt8: SQLValue {}
extension UInt16: SQLValue {}
extension UInt32: SQLValue {}
extension UInt64: SQLValue {}

public extension SQLValue where Self: BinaryFloatingPoint & CustomStringConvertible {
  var string: String { "\(self)" }
}

extension Float: SQLValue {}
extension Double: SQLValue {}

public extension SQLValue where Self: StringProtocol {
  var string: String { "'\(self)'" }
}

extension String: SQLValue {}
