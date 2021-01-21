import Foundation

public protocol WhereQuery {
  func and(_ predicate: Predicate) -> WhereQuery & OrderByQuery & LimitQuery & SQLConvertible
  func or(_ predicate: Predicate) -> WhereQuery & OrderByQuery & LimitQuery & SQLConvertible
}
