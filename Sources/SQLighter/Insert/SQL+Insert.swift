import Foundation

public extension SQL {
  static func insert(into table: SQLTable) -> InsertQuery {
    return Insert(into: table)
  }
}
