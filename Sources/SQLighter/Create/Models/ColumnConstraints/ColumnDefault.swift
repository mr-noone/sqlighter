import Foundation

final class ColumnDefault: ColumnConstraint {
  private enum Default: SQLRepresentable {
    case expression(sql: String)
    case literal(value: SQLValueConvertible)
    
    var sqlString: String {
      switch self {
      case .expression(let sql):
        return "(\(sql))"
      case .literal(let value):
        return value.sqlLiteral
      }
    }
  }
  
  // MARK: - Properties
  
  private let `default`: Default
  
  // MARK: - SQLRepresentable
  
  override var sqlString: String {
    return [super.sqlString, "DEFAULT", `default`.sqlString]
      .filter { !$0.isEmpty }
      .joined(separator: " ")
  }
  
  // MARK: - Inits
  
  init(name: String?, sql expression: String) {
    `default` = .expression(sql: expression)
    super.init(name: name)
  }
  
  init(name: String?, literal value: SQLValueConvertible) {
    `default` = .literal(value: value)
    super.init(name: name)
  }
}
