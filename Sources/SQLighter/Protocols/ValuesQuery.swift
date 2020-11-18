import Foundation

public protocol ValuesQuery {
  func values(_ values: SQLValue?...) -> ValuesQuery & SQLConvertible
}
