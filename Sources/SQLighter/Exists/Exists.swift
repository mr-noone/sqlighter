import Foundation

final class Exists: Select, ExistsQuery {
  // MARK: - SQLConvertible
  
  override func sqlQuery() -> SQLQuery {
    let select = super.sqlQuery()
    let sql = "SELECT EXISTS (\(select.sql))"
    return (sql: sql, args: select.args)
  }
}
