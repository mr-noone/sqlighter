import Foundation

final class Select: Where, SelectQuery {
  // MARK: - Properties
  
  private var buffer = [Column]()
  private var select = [Table]()
  
  // MARK: - Inits
  
  init(table name: TableRepresentable, as alias: String? = nil) {
    self.select = [
      Table(name: name, alias: alias, columns: [.init(name: "*", alias: nil)])
    ]
  }
  
  init(column names: [ColumnRepresentable]) {
    self.buffer = names.map {
      .init(name: $0, alias: nil)
    }
  }
  
  init(column name: ColumnRepresentable, as alias: String) {
    self.buffer = [
      .init(name: name, alias: alias)
    ]
  }
  
  // MARK: - SelectQuery
  
  func column<C>(_ names: C...) -> SelectQuery where C : ColumnRepresentable {
    buffer.append(contentsOf: names.map {
      .init(name: $0, alias: nil)
    })
    return self
  }
  
  func column(_ name: ColumnRepresentable, as alias: String) -> SelectQuery {
    buffer.append(.init(name: name, alias: alias))
    return self
  }
  
  func from(table name: TableRepresentable, as alias: String) -> SelectQuery & WhereClause & SQLConvertible {
    let columns = buffer.count > 0 ? buffer : [.init(name: "*", alias: nil)]
    select.append(.init(name: name, alias: alias, columns: columns))
    buffer = []
    return self
  }
  
  func from(table name: TableRepresentable) -> SelectQuery & WhereClause & SQLConvertible {
    let columns = buffer.count > 0 ? buffer : [.init(name: "*", alias: nil)]
    select.append(.init(name: name, alias: nil, columns: columns))
    buffer = []
    return self
  }
  
  // MARK: - SQLConvertible
  
  override func trim() -> String {
    guard select.isEmpty == false else { return "" }
    
    let columns = select.map {
      let tAlias = $0.alias == nil ? "" : "\($0.alias!)."
      return $0.columns.map {
        let cAlias = $0.alias == nil ? "" : " AS \($0.alias!)"
        return "\(tAlias)\($0.name.columnName)\(cAlias)"
      }.joined(separator: ", ")
    }.joined(separator: ", ")
    
    let tables = select.map {
      "\($0.name.tableName)\($0.alias == nil ? "" : " AS \($0.alias!)")"
    }.joined(separator: ", ")
    
    return ["SELECT", columns, "FROM", tables, super.trim()]
      .filter { !$0.isEmpty }
      .joined(separator: " ")
  }
}
