import Foundation

public protocol WhereClause {
  func `where`(_ predicate: Predicate) -> WhereQuery & SQLConvertible
  func `where`(sql expression: String) -> SQLConvertible
  func `where`(sql expression: String, args: SQLValueConvertible?...) -> SQLConvertible
}
