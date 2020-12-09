import Foundation

public protocol TableConstraintQuery {
  func tablePrimaryKey(columns: SQLColumn...) -> TableConstraintQuery & SQLConvertible
  func tablePrimaryKey(name: String?, columns: SQLColumn...) -> TableConstraintQuery & SQLConvertible
  
  func tableUnique(columns: SQLColumn...) -> TableConstraintQuery & SQLConvertible
  func tableUnique(name: String?, columns: SQLColumn...) -> TableConstraintQuery & SQLConvertible
  
  func tableCheck(sql expression: String) -> TableConstraintQuery & SQLConvertible
  func tableCheck(name: String?, sql expression: String) -> TableConstraintQuery & SQLConvertible
  
  func tableReferences(columns: SQLColumn..., table: SQLTable) -> TableConstraintQuery & SQLConvertible
  func tableReferences(columns: SQLColumn..., table: SQLTable, onDelete: ReferencesActions?, onUpdate: ReferencesActions?) -> TableConstraintQuery & SQLConvertible
  func tableReferences(name: String?, columns: SQLColumn..., table: SQLTable, onDelete: ReferencesActions?, onUpdate: ReferencesActions?) -> TableConstraintQuery & SQLConvertible
}
