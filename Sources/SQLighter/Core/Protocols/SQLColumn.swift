import Foundation

public protocol SQLColumn: SQLRepresentable {}

public extension SQLColumn where Self: CodingKey {
  var sqlString: String { stringValue }
}
