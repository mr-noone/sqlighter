import Foundation

public extension SQL {
  static func update(table: SQLTable) -> UpdateQuery {
    return Update(table: table)
  }
}
