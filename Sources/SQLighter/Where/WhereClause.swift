import Foundation

public protocol WhereClause {
  func `where`(_ predicate: Predicate) -> WhereQuery & OrderByQuery & LimitQuery & SQLConvertible
  func `where`(sql expression: String) -> OrderByQuery & LimitQuery & SQLConvertible
  func `where`(sql expression: String, args: SQLValueConvertible?...) -> OrderByQuery & LimitQuery & SQLConvertible
}
