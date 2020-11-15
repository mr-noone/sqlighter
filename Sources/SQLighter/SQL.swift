import Foundation

public class SQL: SQLQuery {
  // MARK: - SQLQuery
  
  public static func select<C>(column names: C...) -> SelectQuery where C : ColumnRepresentable {
    return Select(column: names)
  }
  
  public static func select(column name: ColumnRepresentable, as alias: String) -> SelectQuery {
    return Select(column: name, as: alias)
  }
  
  public static func select(from table: TableRepresentable, as alias: String) -> SelectQuery & WhereClause & SQLConvertible {
    return Select(table: table, as: alias)
  }
  
  public static func select(from table: TableRepresentable) -> SelectQuery & WhereClause & SQLConvertible {
    return Select(table: table)
  }
}
