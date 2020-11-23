import Foundation

public protocol ValuesQuery {
  func values(_ values: SQLValueConvertible?...) -> ValuesQuery & SQLConvertible
}

public protocol InsertQuery: ValuesQuery {
  func column<C: SQLColumn>(_ names: C...) -> InsertQuery
}
