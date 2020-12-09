import Foundation

public protocol WhereClause {
  func `where`(_ predicate: Predicate) -> WhereQuery & SQLConvertible
}
