import Foundation

final class TableCheck: TableConstraint {
  // MARK: - Properties
  
  private let expression: String
  
  // MARK: - SQLRepresentable
  
  override var sqlString: String {
    [super.sqlString, "CHECK", "(\(expression))"]
      .filter { !$0.isEmpty }
      .joined(separator: " ")
  }
  
  // MARK: - Inits
  
  init(name: String?, expression: String) {
    self.expression = expression
    super.init(name: name)
  }
}
