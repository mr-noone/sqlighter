import Foundation

final class Delete: Where, DeleteQuery {
  // MARK: - Properties
  
  private let table: SQLTable
  
  // MARK: - Inits
  
  init(from table: SQLTable) {
    self.table = table
  }
  
  // MARK: - SQLConvertible
  
  override func sqlQuery() -> SQLQuery {
    let whereQuery = super.sqlQuery()
    let args = whereQuery.args
    let sql = ["DELETE", "FROM", table.sqlString, whereQuery.sql]
      .filter { !$0.isEmpty }
      .joined(separator: " ")
    return .init(sql: sql, args: args)
  }
}
