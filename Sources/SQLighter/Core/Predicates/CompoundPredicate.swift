import Foundation

struct CompoundPredicate: Predicate {
  enum Operator: String, SQLRepresentable {
    case and = "AND"
    case or  = "OR"
    
    var sqlString: String {
      return rawValue
    }
  }
  
  // MARK: - Properties
  
  let `operator`: Operator
  let lhs: Predicate
  let rhs: Predicate
  
  // MARK: - SQLConvertible
  
  func sqlQuery() -> SQLQuery {
    let lhsQuery = lhs.sqlQuery()
    let rhsQuery = rhs.sqlQuery()
    
    let lhsSQL: String
    switch lhs {
    case let lhs as CompoundPredicate where lhs.operator == .or && `operator` == .and:
      lhsSQL = "(\(lhsQuery.sql))"
    default:
      lhsSQL = "\(lhsQuery.sql)"
    }
    
    let rhsSQL: String
    switch rhs {
    case let rhs as CompoundPredicate where rhs.operator == .or && `operator` == .and:
      rhsSQL = "(\(rhsQuery.sql))"
    default:
      rhsSQL = "\(rhsQuery.sql)"
    }
    
    let args = lhsQuery.args + rhsQuery.args
    let sql = "\(lhsSQL) \(`operator`.sqlString) \(rhsSQL)"
    
    return (sql: sql, args: args)
  }
}

// MARK: - Operators

public func && (lhs: Predicate, rhs: Predicate) -> Predicate {
  return CompoundPredicate(operator: .and, lhs: lhs, rhs: rhs)
}

public func || (lhs: Predicate, rhs: Predicate) -> Predicate {
  return CompoundPredicate(operator: .or, lhs: lhs, rhs: rhs)
}
