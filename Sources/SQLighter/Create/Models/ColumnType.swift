import Foundation

public enum ColumnType: String, SQLRepresentable {
  case text = "TEXT"
  case numeric = "NUMERIC"
  case integer = "INTEGER"
  case real = "REAL"
  case blob = "BLOB"
  
  public var sqlString: String {
    return rawValue
  }
}
