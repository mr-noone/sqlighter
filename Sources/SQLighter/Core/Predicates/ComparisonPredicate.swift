import Foundation

struct ComparisonPredicate: Predicate {
  enum Operator: String, SQLRepresentable {
    case equal              = "="
    case notEqual           = "!="
    case lessThan           = "<"
    case greaterThan        = ">"
    case lessThanOrEqual    = "<="
    case greaterThanOrEqual = ">="
    
    var sqlString: String {
      return rawValue
    }
  }
  
  // MARK: - Properties
  
  let `operator`: Operator
  let column: SQLColumn
  let value: SQLValueConvertible?
  
  // MARK: - SQLConvertible
  
  func sqlQuery() -> SQLQuery {
    let sql = "\(column.sqlString) \(`operator`.sqlString) ?"
    return .init(sql: sql, args: [value])
  }
}

// MARK: - Operators

public func == (lhs: SQLColumn, rhs: SQLValueConvertible?) -> Predicate {
  return ComparisonPredicate(operator: .equal, column: lhs, value: rhs)
}

public func != (lhs: SQLColumn, rhs: SQLValueConvertible?) -> Predicate {
  return ComparisonPredicate(operator: .notEqual, column: lhs, value: rhs)
}

public func < (lhs: SQLColumn, rhs: SQLValueConvertible?) -> Predicate {
  return ComparisonPredicate(operator: .lessThan, column: lhs, value: rhs)
}

public func > (lhs: SQLColumn, rhs: SQLValueConvertible?) -> Predicate {
  return ComparisonPredicate(operator: .greaterThan, column: lhs, value: rhs)
}

public func <= (lhs: SQLColumn, rhs: SQLValueConvertible?) -> Predicate {
  return ComparisonPredicate(operator: .lessThanOrEqual, column: lhs, value: rhs)
}

public func >= (lhs: SQLColumn, rhs: SQLValueConvertible?) -> Predicate {
  return ComparisonPredicate(operator: .greaterThanOrEqual, column: lhs, value: rhs)
}
