import Foundation

final class Drop: SQL, DropQuery {
  // MARK: - Properties
  
  private let table: SQLTable
  private var _ifExists: Bool = false
  
  // MARK: - Inits
  
  init(table: SQLTable) {
    self.table = table
  }
  
  // MARK: - DropQuery
  
  func ifExists() -> SQLConvertible {
    _ifExists = true
    return self
  }
  
  // MARK: - SQLConvertible
  
  override func sqlQuery() -> SQLQuery {
    let query: String
    switch _ifExists {
    case true: query = "DROP TABLE IF EXISTS"
    case false: query = "DROP TABLE"
    }
    
    return .init(sql: "\(query) \(table.sqlString)", args: [])
  }
}
