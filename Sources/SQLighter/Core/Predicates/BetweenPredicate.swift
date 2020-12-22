import Foundation

struct BetweenPredicate: Predicate {
  // MARK: - Properties
  
  let column: SQLColumn
  let lower: SQLValueConvertible
  let upper: SQLValueConvertible
  let deny: Bool
  
  // MARK: - SQLConvertible
  
  func sqlQuery() -> SQLQuery {
    return .init(sql: "\(column.sqlString) \(deny ? "NOT BETWEEN" : "BETWEEN") ? AND ?", args: [lower, upper])
  }
}

// MARK: - Operators

public func ~= <T: SQLValueConvertible & Comparable> (lhs: SQLColumn, rhs: ClosedRange<T>) -> Predicate {
  return BetweenPredicate(column: lhs, lower: rhs.lowerBound, upper: rhs.upperBound, deny: false)
}

public func != <T: SQLValueConvertible & Comparable> (lhs: SQLColumn, rhs: ClosedRange<T>) -> Predicate {
  return BetweenPredicate(column: lhs, lower: rhs.lowerBound, upper: rhs.upperBound, deny: true)
}
