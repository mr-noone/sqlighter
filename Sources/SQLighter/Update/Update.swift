import Foundation

final class Update: Where, UpdateQuery, UpdateValue {
  // MARK: - Properties
  
  private let table: SQLTable
  private var columns = [Column]()
  private var values = [SQLValueConvertible?]()
  
  // MARK: - Inits
  
  init(table: SQLTable) {
    self.table = table
  }
  
  // MARK: - UpdateQuery
  
  func column<C>(_ names: C...) -> UpdateQuery & UpdateValue & WhereClause & SQLConvertible where C : SQLColumn {
    return column(names)
  }
  
  func column<C>(_ names: [C]) -> UpdateQuery & UpdateValue & WhereClause & SQLConvertible where C : SQLColumn {
    columns.append(contentsOf: names.map {
      .init(name: $0, alias: nil)
    })
    return self
  }
  
  // MARK: - UpdateValue
  
  func values(_ values: SQLValueConvertible?...) -> UpdateQuery & UpdateValue & WhereClause & SQLConvertible {
    self.values.append(contentsOf: values)
    return self
  }
  
  // MARK: - SQLConvertible
  
  override func sqlQuery() -> SQLQuery {
    let set = columns.map {
      "\($0.name) = ?"
    }.joined(separator: ", ")
    
    let whereQuery = super.sqlQuery()
    let args: [SQLValueConvertible?]
    
    if values.count == columns.count {
      args = values + whereQuery.args
    } else if values.isEmpty {
      args = []
    } else {
      fatalError("values count must equal to columns count")
    }
    
    let sql = ["UPDATE", table.sqlString, "SET", set, whereQuery.sql]
      .filter { !$0.isEmpty }
      .joined(separator: " ")
    
    return (sql: sql, args: args)
  }
}
