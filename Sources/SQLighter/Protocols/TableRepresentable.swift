import Foundation

public protocol TableRepresentable {
  var tableName: String { get }
}

extension String: TableRepresentable {
  public var tableName: String { self }
}
