import Foundation

public protocol WhereQuery {
  func and(_ predicate: Predicate) -> WhereQuery & SQLConvertible
  func or(_ predicate: Predicate) -> WhereQuery & SQLConvertible
}
