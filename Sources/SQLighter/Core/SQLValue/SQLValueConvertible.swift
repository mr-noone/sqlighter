import Foundation

public protocol SQLValueConvertible {
  var sqlValue: SQLValue { get }
  var sqlLiteral: String { get }
}
