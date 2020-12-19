import Foundation

public protocol UpdateQuery {
  func column<C: SQLColumn>(_ names: C...) -> UpdateQuery & UpdateValue & WhereClause & SQLConvertible
  func column<C: SQLColumn>(_ names: [C]) -> UpdateQuery & UpdateValue & WhereClause & SQLConvertible
}
