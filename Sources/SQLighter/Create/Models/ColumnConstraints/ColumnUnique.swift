import Foundation

final class  ColumnUnique: ColumnConstraint {
  // MARK: - SQLRepresentable
  
  override var sqlString: String {
    [super.sqlString, "UNIQUE"]
      .filter { !$0.isEmpty }
      .joined(separator: " ")
  }
}
