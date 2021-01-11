import Foundation

final class Insert: SQL, InsertQuery {
  // MARK: - Properties
  
  private let table: SQLTable
  private var columns = [Column]()
  private var values = [[SQLValueConvertible?]]()
  
  // MARK: - Inits
  
  init(into table: SQLTable) {
    self.table = table
  }
  
  // MARK: - InsertQuery
  
  func column<C>(_ names: C...) -> InsertQuery & SQLConvertible where C : SQLColumn {
    columns.append(contentsOf: names.map {
      .init(name: $0, as: nil)
    })
    return self
  }
  
  func column<C>(_ names: [C]) -> InsertQuery & SQLConvertible where C : SQLColumn {
    columns.append(contentsOf: names.map {
      .init(name: $0, as: nil)
    })
    return self
  }
  
  func values(_ values: SQLValueConvertible?...) -> SQLConvertible & InsertValue {
    self.values.append(values)
    return self
  }
  
  // MARK: - SQLConvertible
  
  override func sqlQuery() -> SQLQuery {
    let columns = self.columns.isEmpty ? "" : self.columns.map { $0.sqlString(with: nil) }
      .joined(separator: ", ")
      .inserted("(", offser: 0)
      .appending(")")
    
    let values: String
    if !self.values.isEmpty {
      values = self.values
        .map { $0.map { _ in "?" }.joined(separator: ", ") }
        .map { "(\($0))" }
        .joined(separator: ", ")
    } else {
      values = self.columns
        .map { _ in "?" }
        .joined(separator: ", ")
        .inserted("(", offser: 0)
        .appending(")")
    }
    
    let args = Arguments(array: self.values.flatMap { $0 })
    let sql = ["INSERT", "INTO", table.sqlString, columns, "VALUES", values]
      .filter { !$0.isEmpty }
      .joined(separator: " ")
    
    return .init(sql: sql, args: args)
  }
}
