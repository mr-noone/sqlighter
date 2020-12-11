import Foundation

final class TablePrimaryKey: TableConstraint {
  // MARK: - Properties
  
  private let columns: [SQLColumn]
  
  // MARK: - SQLRepresentable
  
  override var sqlString: String {
    let columns = self.columns.map { $0.sqlString }.joined(separator: ", ")
    return [super.sqlString, "PRIMARY KEY", "(\(columns))"]
      .filter { !$0.isEmpty }
      .joined(separator: " ")
  }
  
  // MARK: - Inits
  
  init(name: String?, columns: [SQLColumn]) {
    self.columns = columns
    super.init(name: name)
  }
}
