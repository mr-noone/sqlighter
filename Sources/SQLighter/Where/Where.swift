import Foundation

class Where: SQL, WhereClause, WhereQuery {
  // MARK: - Properties
  
  private var predicate: Predicate?
  
  // MARK: - WhereQuery
  
  func `where`(_ predicate: Predicate) -> WhereQuery & SQLConvertible {
    self.predicate = predicate
    return self
  }
  
  func and(_ predicate: Predicate) -> WhereQuery & SQLConvertible {
    guard let lPredicate = self.predicate else {
      fatalError()
    }
    self.predicate = lPredicate && predicate
    return self
  }
  
  func or(_ predicate: Predicate) -> WhereQuery & SQLConvertible {
    guard let lPredicate = self.predicate else {
      fatalError()
    }
    self.predicate = lPredicate || predicate
    return self
  }
  
  // MARK: - SQLConvertible
  
  override func sqlQuery() -> SQLQuery {
    guard let query = predicate?.sqlQuery() else {
      return .init(sql: "", args: [])
    }
    return .init(sql: "WHERE \(query.sql)", args: query.args)
  }
}
