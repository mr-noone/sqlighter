import Foundation

final class Delete: Where, DeleteQuery {
  // MARK: - Properties
  
  private var table: SQLTable
  
  // MARK: - Inits
  
  init(from table: SQLTable) {
    self.table = table
  }
  
  // MARK: - SQLConvertible
  
  override func sqlQuery() -> SQLQuery {
    let whereQuery = super.sqlQuery()
    let args = whereQuery.args
    let sql = ["DELETE", "FROM", table.table, whereQuery.sql]
      .filter { !$0.isEmpty }
      .joined(separator: " ")
    return (sql: sql, args: args)
  }
}
