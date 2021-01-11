import Foundation

public protocol LimitQuery {
  func limit(_ limit: UInt) -> SQLConvertible
  func limit(_ limit: UInt, offset: UInt) -> SQLConvertible
}

public protocol SelectQuery {
  func column<C: SQLColumn>(_ names: C...) -> SelectQuery
  func column(_ name: SQLColumn, as alias: String) -> SelectQuery
  
  func count(_ name: SQLColumn) -> SelectQuery
  func count(_ name: SQLColumn, as alias: String?, distinct: Bool) -> SelectQuery
  
  func from(table name: SQLTable, as alias: String) -> SelectQuery & WhereClause & LimitQuery & SQLConvertible
  func from(table name: SQLTable) -> SelectQuery & WhereClause & LimitQuery & SQLConvertible
}
