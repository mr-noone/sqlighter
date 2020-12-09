import Foundation

public protocol CreateQuery {
  func ifNotExists() -> CreateQuery & ColumnConstraintQuery & TableConstraintQuery & SQLConvertible
  func column(_ name: SQLColumn, type: ColumnType) -> CreateQuery & ColumnConstraintQuery & TableConstraintQuery & SQLConvertible
}
