import Foundation

public protocol InsertQuery: ValuesQuery {
  func column<C: ColumnRepresentable>(_ names: C...) -> InsertQuery
}
