import Foundation

class Where: SQL, WhereClause, SQLConvertible {
  // MARK: - SQLConvertible
  
  func trim() -> String {
    return ""
  }
}
