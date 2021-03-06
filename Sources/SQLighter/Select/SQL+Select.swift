import Foundation

public extension SQL {
  static func select<C: SQLColumn>(column names: C...) -> SelectQuery {
    return Select(column: names)
  }
  
  static func select(column name: SQLColumn, as alias: String) -> SelectQuery {
    return Select(column: name, as: alias)
  }
  
  static func count(column name: SQLColumn, as alias: String? = nil, distinct: Bool = false) -> SelectQuery {
    return Select(count: name, as: alias, distinct: distinct)
  }
  
  static func count(from table: SQLTable) -> SelectQuery & WhereClause & SQLConvertible {
    return Select(count: table, as: nil, distinct: false)
  }
  
  static func select(from table: SQLTable, as alias: String) -> SelectQuery & WhereClause & OrderByQuery & LimitQuery & SQLConvertible {
    return Select(table: table, as: alias)
  }
  
  static func select(from table: SQLTable) -> SelectQuery & WhereClause & OrderByQuery & LimitQuery & SQLConvertible {
    return Select(table: table)
  }
}
