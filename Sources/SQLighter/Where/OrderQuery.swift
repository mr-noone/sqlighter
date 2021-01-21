import Foundation

public protocol OrderByQuery {
  func order(by column: SQLColumn) -> OrderQuery & LimitQuery & SQLConvertible
}

public protocol OrderQuery: OrderByQuery {
  func ascending() -> OrderQuery & LimitQuery & SQLConvertible
  func descending() -> OrderQuery & LimitQuery & SQLConvertible
  func nullsFirst() -> OrderQuery & LimitQuery & SQLConvertible
  func nullsLast() -> OrderQuery & LimitQuery & SQLConvertible
}
