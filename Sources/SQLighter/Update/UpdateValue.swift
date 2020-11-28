import Foundation

public protocol UpdateValue {
  func values(_ values: SQLValueConvertible?...) -> UpdateQuery & UpdateValue & WhereClause & SQLConvertible
}
