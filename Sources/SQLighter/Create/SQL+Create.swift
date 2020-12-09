import Foundation

public extension SQL {
  static func create(table name: SQLTable) -> CreateQuery {
    return Create(table: name)
  }
}
