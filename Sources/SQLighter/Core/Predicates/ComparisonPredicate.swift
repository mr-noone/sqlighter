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
  let expression: SQLConvertible?
  
  // MARK: - SQLConvertible
  
  func sqlQuery() -> SQLQuery {
    let rightOperand: String
    let arguments: Arguments
    
    if let query = expression?.sqlQuery() {
      rightOperand = "(\(query.sql))"
      arguments = query.args
    } else {
      rightOperand = "?"
      arguments = [value]
    }
    
    let sql = "\(column.sqlString) \(`operator`.sqlString) \(rightOperand)"
    return .init(sql: sql, args: arguments)
  }
}

// MARK: - Operators

public func == (lhs: SQLColumn, rhs: SQLValueConvertible?) -> Predicate {
  return ComparisonPredicate(operator: .equal, column: lhs, value: rhs, expression: nil)
}

public func == (lhs: SQLColumn, rhs: SQLConvertible) -> Predicate {
  return ComparisonPredicate(operator: .equal, column: lhs, value: nil, expression: rhs)
}

public func != (lhs: SQLColumn, rhs: SQLValueConvertible?) -> Predicate {
  return ComparisonPredicate(operator: .notEqual, column: lhs, value: rhs, expression: nil)
}

public func != (lhs: SQLColumn, rhs: SQLConvertible) -> Predicate {
  return ComparisonPredicate(operator: .notEqual, column: lhs, value: nil, expression: rhs)
}

public func < (lhs: SQLColumn, rhs: SQLValueConvertible?) -> Predicate {
  return ComparisonPredicate(operator: .lessThan, column: lhs, value: rhs, expression: nil)
}

public func < (lhs: SQLColumn, rhs: SQLConvertible) -> Predicate {
  return ComparisonPredicate(operator: .lessThan, column: lhs, value: nil, expression: rhs)
}

public func > (lhs: SQLColumn, rhs: SQLValueConvertible?) -> Predicate {
  return ComparisonPredicate(operator: .greaterThan, column: lhs, value: rhs, expression: nil)
}

public func > (lhs: SQLColumn, rhs: SQLConvertible) -> Predicate {
  return ComparisonPredicate(operator: .greaterThan, column: lhs, value: nil, expression: rhs)
}

public func <= (lhs: SQLColumn, rhs: SQLValueConvertible?) -> Predicate {
  return ComparisonPredicate(operator: .lessThanOrEqual, column: lhs, value: rhs, expression: nil)
}

public func <= (lhs: SQLColumn, rhs: SQLConvertible) -> Predicate {
  return ComparisonPredicate(operator: .lessThanOrEqual, column: lhs, value: nil, expression: rhs)
}

public func >= (lhs: SQLColumn, rhs: SQLValueConvertible?) -> Predicate {
  return ComparisonPredicate(operator: .greaterThanOrEqual, column: lhs, value: rhs, expression: nil)
}

public func >= (lhs: SQLColumn, rhs: SQLConvertible) -> Predicate {
  return ComparisonPredicate(operator: .greaterThanOrEqual, column: lhs, value: nil, expression: rhs)
}
