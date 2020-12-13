import Foundation

public protocol SQLConvertible {
  func sqlQuery() -> SQLQuery
  func sqlString() -> String
}

public extension SQLConvertible {
  func sqlString() -> String {
    let query = sqlQuery()
    let args = query.args
    var sql = query.sql
    
    for arg in args {
      if let range = sql.range(of: "?") {
        sql.replaceSubrange(range, with: arg.sqlLiteral)
      }
    }
    
    return sql
  }
}
