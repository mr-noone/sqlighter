import Foundation

public extension SQL {
  static func drop(table name: SQLTable) -> DropQuery & SQLConvertible {
    return Drop(table: name)
  }
}
