import Foundation

public extension SQL {
  static func exists(in table: SQLTable) -> ExistsQuery & WhereClause {
    return Exists(table: table)
  }
}
