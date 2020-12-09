import Foundation

final class ColumnReferences: ColumnConstraint {
  // MARK: - Properties
  
  private let references: SQLTable
  private let onDelete: ReferencesActions?
  private let onUpdate: ReferencesActions?
  
  // MARK: - ColumnConstraint
  
  override var sqlString: String {
    let onDelete = self.onDelete != nil ? "ON DELETE \(self.onDelete!.sqlString)" : ""
    let onUpdate = self.onUpdate != nil ? "ON UPDATE \(self.onUpdate!.sqlString)" : ""
    
    return [super.sqlString, "REFERENCES", references.table, onDelete, onUpdate]
      .filter { !$0.isEmpty }
      .joined(separator: " ")
  }
  
  // MARK: - Inits
  
  init(name: String?, table: SQLTable, onDelete: ReferencesActions?, onUpdate: ReferencesActions?) {
    self.references = table
    self.onDelete = onDelete
    self.onUpdate = onUpdate
    super.init(name: name)
  }
}
