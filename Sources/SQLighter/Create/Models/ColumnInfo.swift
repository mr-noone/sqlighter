import Foundation

struct ColumnInfo: SQLRepresentable {
  let name: SQLColumn
  let type: ColumnType
  var constraints = [ColumnConstraint]()
  
  var sqlString: String {
    let constraints = self.constraints
      .map { $0.sqlString }
      .joined(separator: " ")
    
    return [name.sqlString, type.sqlString, constraints]
      .filter { !$0.isEmpty }
      .joined(separator: " ")
  }
}
