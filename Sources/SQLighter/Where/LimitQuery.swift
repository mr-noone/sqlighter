import Foundation

public protocol LimitQuery {
  func limit(_ limit: UInt) -> SQLConvertible
  func limit(_ limit: UInt, offset: UInt) -> SQLConvertible
}
