import Foundation

public extension SQL {
  static func delete(from table: SQLTable) -> DeleteQuery & WhereClause & SQLConvertible {
    return Delete(from: table)
  }
}
