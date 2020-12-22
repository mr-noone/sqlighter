import Foundation

struct InPredicate: Predicate {
  // MARK: - Properties
  
  let column: SQLColumn
  let values: [SQLValueConvertible?]?
  let expression: SQLConvertible?
  
  // MARK: - SQLConvertible
  
  func sqlQuery() -> SQLQuery {
    let arguments: Arguments
    let inValues: String
    
    switch (values, expression) {
    case let (values?, _):
      arguments = Arguments(array: values)
      inValues = Array(repeating: "?", count: values.count).joined(separator: ", ")
    case let (_, expression?):
      arguments = expression.sqlQuery().args
      inValues = expression.sqlQuery().sql
    default:
      fatalError()
    }
    
    return .init(sql: "\(column.sqlString) IN (\(inValues))", args: arguments)
  }
}

// MARK: - Operators

public func ~= (lhs: SQLColumn, rhs: [SQLValueConvertible?]) -> Predicate {
  return InPredicate(column: lhs, values: rhs, expression: nil)
}

public func ~= (lhs: SQLColumn, rhs: SQLConvertible) -> Predicate {
  return InPredicate(column: lhs, values: nil, expression: rhs)
}
