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
    let `operator`: String
    let arguments: Arguments
    let sql: String
    
    if let query = expression?.sqlQuery() {
      `operator` = self.operator.sqlString
      rightOperand = "(\(query.sql))"
      arguments = query.args
    } else {
      switch value {
      case .none where self.operator == .equal:
        `operator` = "IS NULL"
        rightOperand = ""
        arguments = []
      case .none where self.operator == .notEqual:
        `operator` = "NOT NULL"
        rightOperand = ""
        arguments = []
      default:
        `operator` = self.operator.sqlString
        rightOperand = "?"
        arguments = [value]
      }
    }
    
    if rightOperand.isEmpty == false {
      sql = "\(column.sqlString) \(`operator`) \(rightOperand)"
    } else {
      sql = "\(column.sqlString) \(`operator`)"
    }
    
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
