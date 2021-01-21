import Foundation

class Where: SQL, OrderQuery, LimitQuery, WhereClause, WhereQuery {
  // MARK: - Properties
  
  private var predicate: Predicate?
  private var orders: [Order] = []
  private var limit: UInt = 0
  private var offset: UInt = 0
  
  // MARK: - WhereQuery
  
  func `where`(_ predicate: Predicate) -> WhereQuery & OrderByQuery & LimitQuery & SQLConvertible {
    self.predicate = predicate
    return self
  }
  
  func `where`(sql expression: String) -> OrderByQuery & LimitQuery & SQLConvertible {
    self.predicate = ExpressionPredicate(expression: expression, values: [])
    return self
  }
  
  func `where`(sql expression: String, args: SQLValueConvertible?...) -> OrderByQuery & LimitQuery & SQLConvertible {
    self.predicate = ExpressionPredicate(expression: expression, values: args)
    return self
  }
  
  func and(_ predicate: Predicate) -> WhereQuery & OrderByQuery & LimitQuery & SQLConvertible {
    guard let lPredicate = self.predicate else {
      fatalError()
    }
    self.predicate = lPredicate && predicate
    return self
  }
  
  func or(_ predicate: Predicate) -> WhereQuery & OrderByQuery & LimitQuery & SQLConvertible {
    guard let lPredicate = self.predicate else {
      fatalError()
    }
    self.predicate = lPredicate || predicate
    return self
  }
  
  // MARK: - LimitQuery
  
  func limit(_ limit: UInt) -> SQLConvertible {
    self.limit = limit
    return self
  }
  
  func limit(_ limit: UInt, offset: UInt) -> SQLConvertible {
    self.limit = limit
    self.offset = offset
    return self
  }
  
  // MARK: - OrderQuery
  
  func order(by column: SQLColumn) -> OrderQuery & LimitQuery & SQLConvertible {
    orders.append(Order(column: column))
    return self
  }
  
  func ascending() -> OrderQuery & LimitQuery & SQLConvertible {
    orders[orders.count - 1].ascending = Ascending(ascending: true)
    return self
  }
  
  func descending() -> OrderQuery & LimitQuery & SQLConvertible {
    orders[orders.count - 1].ascending = Ascending(ascending: false)
    return self
  }
  
  func nullsFirst() -> OrderQuery & LimitQuery & SQLConvertible {
    orders[orders.count - 1].nullsFirst = NullsFirst(nullsFirst: true)
    return self
  }
  
  func nullsLast() -> OrderQuery & LimitQuery & SQLConvertible {
    orders[orders.count - 1].nullsFirst = NullsFirst(nullsFirst: false)
    return self
  }
  
  // MARK: - SQLConvertible
  
  override func sqlQuery() -> SQLQuery {
    let query = predicate?.sqlQuery()
    let `where` = query?.sql.inserted("WHERE ", offser: 0) ?? ""
    
    let order = orders.isEmpty ? "" : "ORDER BY \(orders.map { $0.sqlString }.joined(separator: ", "))"
    
    let limit = self.limit > 0 ? "LIMIT \(self.limit)" : ""
    let offset = self.offset > 0 ? "OFFSET \(self.offset)" : ""
    
    let sql = [`where`, order, limit, offset]
      .filter { !$0.isEmpty }
      .joined(separator: " ")
    
    return .init(sql: sql, args: query?.args ?? [])
  }
}
