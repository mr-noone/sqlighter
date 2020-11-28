import Foundation

public protocol InsertValue {
  func values(_ values: SQLValueConvertible?...) -> InsertValue & SQLConvertible
}
