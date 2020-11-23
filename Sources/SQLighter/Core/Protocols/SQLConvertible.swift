import Foundation

public typealias SQLQuery = (sql: String, args: [SQLValueConvertible?])

public protocol SQLConvertible {
  func sqlQuery() -> SQLQuery
  func sqlString() -> String
}

public extension SQLConvertible {
  func sqlString() -> String {
    let query = sqlQuery()
    var sql = query.sql
    let args = query.args
    
    for arg in args {
      if let range = sql.range(of: "?") {
        sql.replaceSubrange(range, with: arg?.sqlLiteral ?? "NULL")
      } else {
        break
      }
    }
    
    return sql
  }
}
