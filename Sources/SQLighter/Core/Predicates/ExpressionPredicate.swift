import Foundation

struct ExpressionPredicate: Predicate {
  // MARK: - Properties
  
  let expression: String
  let values: [SQLValueConvertible?]
  
  // MARK: - SQLConvertible
  
  func sqlQuery() -> SQLQuery {
    return .init(sql: expression, args: Arguments(array: values))
  }
}
