import Foundation

struct InPredicate: Predicate {
  // MARK: - Properties
  
  let column: SQLColumn
  let values: [SQLValueConvertible?]
  
  // MARK: - SQLConvertible
  
  func sqlQuery() -> SQLQuery {
    let values = Array(repeating: "?", count: self.values.count).joined(separator: ", ")
    return .init(sql: "\(column.sqlString) IN (\(values))", args: Arguments(array: self.values))
  }
}

// MARK: - Operators

public func ~= (lhs: SQLColumn, rhs: [SQLValueConvertible?]) -> Predicate {
  return InPredicate(column: lhs, values: rhs)
}
