import Foundation

final class Insert: SQL, InsertQuery {
  // MARK: - Properties
  
  private let table: SQLTable
  private var columns = [Column]()
  private var values = [[SQLValueConvertible?]]()
  
  // MARK: - Inits
  
  init(table name: SQLTable) {
    self.table = name
  }
  
  // MARK: - InsertQuery
  
  func column<C>(_ names: C...) -> InsertQuery where C : SQLColumn {
    columns.append(contentsOf: names.map {
      .init(name: $0, alias: nil)
    })
    return self
  }
  
  func values(_ values: SQLValueConvertible?...) -> SQLConvertible & ValuesQuery {
    self.values.append(values)
    return self
  }
  
  // MARK: - SQLConvertible
  
  override func sqlQuery() -> SQLQuery {
    let columns = self.columns.isEmpty ? "" : self.columns.map { $0.name.column }
      .joined(separator: ", ")
      .inserted("(", offser: 0)
      .appending(")")
    
    let values = self.values
      .map { $0.map { _ in "?" }.joined(separator: ", ") }
      .map { "(\($0))" }
      .joined(separator: ", ")
    
    let sql = ["INSERT", "INTO", table.table, columns, "VALUES", values]
      .filter { !$0.isEmpty }
      .joined(separator: " ")
    
    let args = self.values.flatMap { $0 }
    
    return (sql: sql, args: args)
  }
}
