import Foundation

public protocol UpdateQuery {
  func column<C: SQLColumn>(_ names: C...) -> UpdateQuery & UpdateValue
  func column<C: SQLColumn>(_ names: [C]) -> UpdateQuery & UpdateValue
}
