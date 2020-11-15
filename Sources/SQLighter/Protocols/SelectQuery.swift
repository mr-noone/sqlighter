import Foundation

public protocol SelectQuery {
  func column<C: ColumnRepresentable>(_ names: C...) -> SelectQuery
  func column(_ name: ColumnRepresentable, as alias: String) -> SelectQuery
  
  func from(table name: TableRepresentable, as alias: String) -> SelectQuery & WhereClause & SQLConvertible
  func from(table name: TableRepresentable) -> SelectQuery & WhereClause & SQLConvertible
}
