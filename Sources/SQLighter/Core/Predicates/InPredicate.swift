import Foundation

struct InPredicate: Predicate {
  // MARK: - Properties
  
  let column: SQLColumn
  let values: [SQLValueConvertible?]
  
  // MARK: - SQLConvertible
  
  func sqlQuery() -> SQLQuery {
    let values = Array(repeating: "?", count: self.values.count).joined(separator: ", ")
    return (sql: "\(column.sqlString) IN (\(values))", args: self.values)
  }
}

// MARK: - Operators

public func ~= (lhs: SQLColumn, rhs: [SQLValueConvertible?]) -> Predicate {
  return InPredicate(column: lhs, values: rhs)
}
