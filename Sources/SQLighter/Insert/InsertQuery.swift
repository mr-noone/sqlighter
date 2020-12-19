import Foundation

public protocol InsertQuery: InsertValue {
  func column<C: SQLColumn>(_ names: C...) -> InsertQuery & SQLConvertible
  func column<C: SQLColumn>(_ names: [C]) -> InsertQuery & SQLConvertible
}
