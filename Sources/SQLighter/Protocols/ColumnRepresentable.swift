import Foundation

public protocol ColumnRepresentable {
  var columnName: String { get }
}

extension String: ColumnRepresentable {
  public var columnName: String { self }
}
