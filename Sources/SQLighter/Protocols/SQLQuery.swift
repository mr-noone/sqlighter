import Foundation

public protocol SQLQuery {
  static func select<C: ColumnRepresentable>(column names: C...) -> SelectQuery
  static func select(column name: ColumnRepresentable, as alias: String) -> SelectQuery
  
  static func select(from table: TableRepresentable, as alias: String) -> SelectQuery & WhereClause & SQLConvertible
  static func select(from table: TableRepresentable) -> SelectQuery & WhereClause & SQLConvertible
  
  static func insert(into table: TableRepresentable) -> InsertQuery
}
