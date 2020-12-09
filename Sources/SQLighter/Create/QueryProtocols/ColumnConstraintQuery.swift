import Foundation

public protocol ColumnConstraintQuery {
  func primaryKey() -> CreateQuery & ColumnConstraintQuery & TableConstraintQuery & SQLConvertible
  func primaryKey(name: String?, autoincrement: Bool) -> CreateQuery & ColumnConstraintQuery & TableConstraintQuery & SQLConvertible
  
  func notNull() -> CreateQuery & ColumnConstraintQuery & TableConstraintQuery & SQLConvertible
  func notNull(name: String?) -> CreateQuery & ColumnConstraintQuery & TableConstraintQuery & SQLConvertible
  
  func unique() -> CreateQuery & ColumnConstraintQuery & TableConstraintQuery & SQLConvertible
  func unique(name: String?) -> CreateQuery & ColumnConstraintQuery & TableConstraintQuery & SQLConvertible
  
  func check(sql expression: String) -> CreateQuery & ColumnConstraintQuery & TableConstraintQuery & SQLConvertible
  func check(name: String?, sql expression: String) -> CreateQuery & ColumnConstraintQuery & TableConstraintQuery & SQLConvertible
  
  func `default`(sql expression: String) -> CreateQuery & ColumnConstraintQuery & TableConstraintQuery & SQLConvertible
  func `default`(value: SQLValueConvertible) -> CreateQuery & ColumnConstraintQuery & TableConstraintQuery & SQLConvertible
  func `default`(name: String?, sql expression: String) -> CreateQuery & ColumnConstraintQuery & TableConstraintQuery & SQLConvertible
  func `default`(name: String?, value: SQLValueConvertible) -> CreateQuery & ColumnConstraintQuery & TableConstraintQuery & SQLConvertible
  
  func references(table: SQLTable) -> CreateQuery & ColumnConstraintQuery & TableConstraintQuery & SQLConvertible
  func references(table: SQLTable, onDelete: ReferencesActions?, onUpdate: ReferencesActions?) -> CreateQuery & ColumnConstraintQuery & TableConstraintQuery & SQLConvertible
  func references(name: String?, table: SQLTable, onDelete: ReferencesActions?, onUpdate: ReferencesActions?) -> CreateQuery & ColumnConstraintQuery & TableConstraintQuery & SQLConvertible
}
