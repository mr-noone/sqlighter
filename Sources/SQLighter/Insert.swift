import Foundation

final class Insert: SQL, InsertQuery, SQLConvertible {
  // MARK: - Properties
  
  private let table: TableRepresentable
  private var columns: [Column]?
  private var values = [[SQLValue?]]()
  
  // MARK: - Inits
  
  init(table name: TableRepresentable) {
    self.table = name
  }
  
  // MARK: - InsertQuery
  
  func column<C>(_ names: C...) -> InsertQuery where C : ColumnRepresentable {
    columns = names.map { .init(name: $0, alias: nil) }
    return self
  }
  
  func values(_ values: SQLValue?...) -> ValuesQuery & SQLConvertible {
    self.values.append(values)
    return self
  }
  
  // MARK: - SQLConvertible
  
  func trim() -> String {
    let columns: String
    if let c = self.columns {
      columns = "(\(c.map { $0.name.columnName }.joined(separator: ", ")))"
    } else {
      columns = ""
    }
    
    let values = self.values
      .map { $0.map { $0?.string ?? "NULL" }.joined(separator: ", ") }
      .map { "(\($0))" }
      .joined(separator: ", ")
    
    return ["INSERT", "INTO", table.tableName, columns, "VALUES", values]
      .filter { !$0.isEmpty }
      .joined(separator: " ")
  }
}
