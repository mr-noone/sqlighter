import Foundation

class Select: Where, SelectQuery {
  // MARK: - Properties
  
  private var buffer = [Column]()
  private var select = [Table]()
  
  // MARK: - Inits
  
  init(table name: SQLTable, as alias: String? = nil) {
    self.select = [
      Table(name: name, alias: alias, columns: [.init(name: "*", as: nil)])
    ]
  }
  
  init(count table: SQLTable, as alias: String?, distinct: Bool) {
    self.select = [
      Table(name: table, alias: alias, columns: [CountColumn(name: "*", as: nil, distinct: distinct)])
    ]
  }
  
  init(count column: SQLColumn, as alias: String?, distinct: Bool) {
    self.buffer = [
      CountColumn(name: column, as: alias, distinct: distinct)
    ]
  }
  
  init(column names: [SQLColumn]) {
    self.buffer = names.map {
      .init(name: $0, as: nil)
    }
  }
  
  init(column name: SQLColumn, as alias: String) {
    self.buffer = [
      .init(name: name, as: alias)
    ]
  }
  
  // MARK: - SelectQuery
  
  func column<C>(_ names: C...) -> SelectQuery where C : SQLColumn {
    buffer.append(contentsOf: names.map {
      .init(name: $0, as: nil)
    })
    return self
  }
  
  func column(_ name: SQLColumn, as alias: String) -> SelectQuery {
    buffer.append(.init(name: name, as: alias))
    return self
  }
  
  func count(_ name: SQLColumn) -> SelectQuery {
    return count(name, as: nil, distinct: false)
  }
  
  func count(_ name: SQLColumn, as alias: String?, distinct: Bool) -> SelectQuery {
    buffer.append(CountColumn(name: name, as: alias, distinct: distinct))
    return self
  }
  
  func from(table name: SQLTable, as alias: String) -> SelectQuery & WhereClause & OrderByQuery & LimitQuery & SQLConvertible {
    let columns = buffer.count > 0 ? buffer : [.init(name: "*", as: nil)]
    select.append(.init(name: name, alias: alias, columns: columns))
    buffer = []
    return self
  }
  
  func from(table name: SQLTable) -> SelectQuery & WhereClause & OrderByQuery & LimitQuery & SQLConvertible {
    let columns = buffer.count > 0 ? buffer : [.init(name: "*", as: nil)]
    select.append(.init(name: name, alias: nil, columns: columns))
    buffer = []
    return self
  }
  
  // MARK: - SQLConvertible
  
  override func sqlQuery() -> SQLQuery {
    let columns = select.map { table in
      table.columns.map { column in
        column.sqlString(with: table.alias)
      }.joined(separator: ", ")
    }.joined(separator: ", ")
    
    let tables = select.map {
      "\($0.name.sqlString)\($0.alias == nil ? "" : " AS \($0.alias!)")"
    }.joined(separator: ", ")
    
    let whereQuery = super.sqlQuery()
    
    let sql = ["SELECT", columns, "FROM", tables, whereQuery.sql]
      .filter { !$0.isEmpty }
      .joined(separator: " ")
    
    return .init(sql: sql, args: whereQuery.args)
  }
}
