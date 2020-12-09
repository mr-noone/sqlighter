import Foundation

public protocol DropQuery {
  func ifExists() -> SQLConvertible
}
