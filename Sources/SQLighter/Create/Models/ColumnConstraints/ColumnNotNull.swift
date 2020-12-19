import Foundation

final class ColumnNotNull: ColumnConstraint {
  // MARK: - SQLRepresentable
  
  override var sqlString: String {
    [super.sqlString, "NOT NULL"]
      .filter { !$0.isEmpty }
      .joined(separator: " ")
  }
}
