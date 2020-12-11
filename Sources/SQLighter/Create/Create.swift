import Foundation

final class Create: SQL, CreateQuery, ColumnConstraintQuery, TableConstraintQuery {
  // MARK: - Properties
  
  private let table: SQLTable
  private var _ifNotExists: Bool = false
  private var columns = [ColumnInfo]()
  private var constraints = [TableConstraint]()
  
  // MARK: - Inits
  
  init(table: SQLTable) {
    self.table = table
  }
  
  // MARK: - CreateQuery
  
  func ifNotExists() -> ColumnConstraintQuery & CreateQuery & SQLConvertible & TableConstraintQuery {
    _ifNotExists = true
    return self
  }
  
  func column(_ name: SQLColumn, type: ColumnType) -> ColumnConstraintQuery & CreateQuery & SQLConvertible & TableConstraintQuery {
    columns.append(.init(name: name, type: type))
    return self
  }
  
  // MARK: - ColumnConstraintQuery
  
  func primaryKey() -> ColumnConstraintQuery & CreateQuery & SQLConvertible & TableConstraintQuery {
    return primaryKey(name: nil, autoincrement: false)
  }
  
  func primaryKey(name: String?, autoincrement: Bool) -> ColumnConstraintQuery & CreateQuery & SQLConvertible & TableConstraintQuery {
    let constraint = ColumnPrimaryKey(name: name, autoincrement: autoincrement)
    columns[columns.count - 1].constraints.append(constraint)
    return self
  }
  
  func notNull() -> ColumnConstraintQuery & CreateQuery & SQLConvertible & TableConstraintQuery {
    return notNull(name: nil)
  }
  
  func notNull(name: String?) -> ColumnConstraintQuery & CreateQuery & SQLConvertible & TableConstraintQuery {
    let constraint = ColumnNotNull(name: name)
    columns[columns.count - 1].constraints.append(constraint)
    return self
  }
  
  func unique() -> ColumnConstraintQuery & CreateQuery & SQLConvertible & TableConstraintQuery {
    return unique(name: nil)
  }
  
  func unique(name: String?) -> ColumnConstraintQuery & CreateQuery & SQLConvertible & TableConstraintQuery {
    let constraint = ColumnUnique(name: name)
    columns[columns.count - 1].constraints.append(constraint)
    return self
  }
  
  func check(sql expression: String) -> ColumnConstraintQuery & CreateQuery & SQLConvertible & TableConstraintQuery {
    return check(name: nil, sql: expression)
  }
  
  func check(name: String?, sql expression: String) -> ColumnConstraintQuery & CreateQuery & SQLConvertible & TableConstraintQuery {
    let constraint = ColumnCheck(name: name, expression: expression)
    columns[columns.count - 1].constraints.append(constraint)
    return self
  }
  
  func `default`(sql expression: String) -> ColumnConstraintQuery & CreateQuery & SQLConvertible & TableConstraintQuery {
    return `default`(name: nil, sql: expression)
  }
  
  func `default`(value: SQLValueConvertible) -> ColumnConstraintQuery & CreateQuery & SQLConvertible & TableConstraintQuery {
    return `default`(name: nil, value: value)
  }
  
  func `default`(name: String?, sql expression: String) -> ColumnConstraintQuery & CreateQuery & SQLConvertible & TableConstraintQuery {
    let constraint = ColumnDefault(name: name, sql: expression)
    columns[columns.count - 1].constraints.append(constraint)
    return self
  }
  
  func `default`(name: String?, value: SQLValueConvertible) -> ColumnConstraintQuery & CreateQuery & SQLConvertible & TableConstraintQuery {
    let constraint = ColumnDefault(name: name, literal: value)
    columns[columns.count - 1].constraints.append(constraint)
    return self
  }
  
  func references(table: SQLTable) -> ColumnConstraintQuery & CreateQuery & SQLConvertible & TableConstraintQuery {
    return references(name: nil, table: table, onDelete: nil, onUpdate: nil)
  }
  
  func references(table: SQLTable, onDelete: ReferencesActions?, onUpdate: ReferencesActions?) -> ColumnConstraintQuery & CreateQuery & SQLConvertible & TableConstraintQuery {
    return references(name: nil, table: table, onDelete: onDelete, onUpdate: onUpdate)
  }
  
  func references(name: String?, table: SQLTable, onDelete: ReferencesActions?, onUpdate: ReferencesActions?) -> ColumnConstraintQuery & CreateQuery & SQLConvertible & TableConstraintQuery {
    let constraint = ColumnReferences(name: name, table: table, onDelete: onDelete, onUpdate: onUpdate)
    columns[columns.count - 1].constraints.append(constraint)
    return self
  }
  
  // MARK: - TableConstraintQuery
  
  func tablePrimaryKey(columns: SQLColumn...) -> TableConstraintQuery & SQLConvertible {
    constraints.append(TablePrimaryKey(name: nil, columns: columns))
    return self
  }
  
  func tablePrimaryKey(name: String?, columns: SQLColumn...) -> TableConstraintQuery & SQLConvertible {
    constraints.append(TablePrimaryKey(name: name, columns: columns))
    return self
  }
  
  func tableUnique(columns: SQLColumn...) -> SQLConvertible & TableConstraintQuery {
    constraints.append(TableUnique(name: nil, columns: columns))
    return self
  }
  
  func tableUnique(name: String?, columns: SQLColumn...) -> SQLConvertible & TableConstraintQuery {
    constraints.append(TableUnique(name: name, columns: columns))
    return self
  }
  
  func tableCheck(sql expression: String) -> SQLConvertible & TableConstraintQuery {
    return tableCheck(name: nil, sql: expression)
  }
  
  func tableCheck(name: String?, sql expression: String) -> SQLConvertible & TableConstraintQuery {
    constraints.append(TableCheck(name: name, expression: expression))
    return self
  }
  
  func tableReferences(columns: SQLColumn..., table: SQLTable) -> SQLConvertible & TableConstraintQuery {
    constraints.append(TableForeignKey(name: nil, columns: columns, table: table, onDelete: nil, onUpdate: nil))
    return self
  }
  
  func tableReferences(columns: SQLColumn..., table: SQLTable, onDelete: ReferencesActions?, onUpdate: ReferencesActions?) -> SQLConvertible & TableConstraintQuery {
    constraints.append(TableForeignKey(name: nil, columns: columns, table: table, onDelete: onDelete, onUpdate: onUpdate))
    return self
  }
  
  func tableReferences(name: String?, columns: SQLColumn..., table: SQLTable, onDelete: ReferencesActions?, onUpdate: ReferencesActions?) -> SQLConvertible & TableConstraintQuery {
    constraints.append(TableForeignKey(name: name, columns: columns, table: table, onDelete: onDelete, onUpdate: onUpdate))
    return self
  }
  
  // MARK: - SQLConvertible
  
  override func sqlQuery() -> SQLQuery {
    let columns = self.columns.map { $0.sqlString }
    let constraints = self.constraints.map { $0.sqlString }
    let info = (columns + constraints).joined(separator: ", ")
    
    let query: String
    switch _ifNotExists {
    case true: query = "CREATE TABLE IF NOT EXISTS"
    case false: query = "CREATE TABLE"
    }
    
    let sql = "\(query) \(table.sqlString) (\(info))"
    
    return (sql: sql, args: [])
  }
}
