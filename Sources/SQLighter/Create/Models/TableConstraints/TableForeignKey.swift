import Foundation

final class TableForeignKey: TableConstraint {
  // MARK: - Properties
  
  private let columns: [SQLColumn]
  private let references: SQLTable
  private let onDelete: ReferencesActions?
  private let onUpdate: ReferencesActions?
  
  // MARK: - ColumnConstraint
  
  override var sqlString: String {
    let columns = self.columns.map { $0.column }.joined(separator: ", ")
    let table = references.table
    
    let onDelete = self.onDelete != nil ? "ON DELETE \(self.onDelete!.sqlString)" : ""
    let onUpdate = self.onUpdate != nil ? "ON UPDATE \(self.onUpdate!.sqlString)" : ""
    
    return [super.sqlString, "FOREIGN KEY", "(\(columns))", "REFERENCES", table, onDelete, onUpdate]
      .filter { !$0.isEmpty }
      .joined(separator: " ")
  }
  
  // MARK: - Inits
  
  init(name: String?,
       columns: [SQLColumn],
       table: SQLTable,
       onDelete: ReferencesActions?,
       onUpdate: ReferencesActions?) {
    self.columns = columns
    self.references = table
    self.onDelete = onDelete
    self.onUpdate = onUpdate
    super.init(name: name)
  }
}
