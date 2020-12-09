import Foundation

public protocol SelectQuery {
  func column<C: SQLColumn>(_ names: C...) -> SelectQuery
  func column(_ names: SQLColumn, as alias: String) -> SelectQuery
  
  func from(table name: SQLTable, as alias: String) -> SelectQuery & WhereClause & SQLConvertible
  func from(table name: SQLTable) -> SelectQuery & WhereClause & SQLConvertible
}
