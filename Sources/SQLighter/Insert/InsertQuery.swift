import Foundation

public protocol InsertQuery: InsertValue {
  func column<C: SQLColumn>(_ names: C...) -> InsertQuery
  func column<C: SQLColumn>(_ names: [C]) -> InsertQuery
}
