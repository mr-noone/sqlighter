import Foundation

public enum ReferencesActions: String, SQLRepresentable {
  case setNull    = "SET NULL"
  case setDefault = "SET DEFAULT"
  case cascade    = "CASCADE"
  case restrict   = "RESTRICT"
  case noAction   = "NO ACTION"
  
  public var sqlString: String {
    return rawValue
  }
}
