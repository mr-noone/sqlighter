import Foundation

final class ColumnPrimaryKey: ColumnConstraint {
  // MARK: - Properties
  
  private let autoincrement: Bool
  
  // MARK: - SQLRepresentable
  
  override var sqlString: String {
    [super.sqlString, "PRIMARY KEY", autoincrement ? "AUTOINCREMENT" : ""]
      .filter { !$0.isEmpty }
      .joined(separator: " ")
  }
  
  // MARK: - Inits
  
  init(name: String?, autoincrement: Bool) {
    self.autoincrement = autoincrement
    super.init(name: name)
  }
}
