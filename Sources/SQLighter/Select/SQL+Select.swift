import Foundation

public extension SQL {
  static func select<C: SQLColumn>(column names: C...) -> SelectQuery {
    return Select(column: names)
  }
  
  static func select(column name: SQLColumn, as alias: String) -> SelectQuery {
    return Select(column: name, as: alias)
  }
  
  static func select(from table: SQLTable, as alias: String) -> SelectQuery & SQLConvertible {
    return Select(table: table, as: alias)
  }
  
  static func select(from table: SQLTable) -> SelectQuery & SQLConvertible {
    return Select(table: table)
  }
}
