import Foundation

public struct Arguments {
  public typealias Element = SQLValue
  
  // MARK: - Properties
  
  private var values: [Element] = []
  private var cursor: Int = 0
  
  // MARK: - Inits
  
  public init(array elements: [Element]) {
    values = elements
  }
  
  public init(array elements: [SQLValueConvertible?]) {
    self.init(array: elements.map { $0?.sqlValue ?? .null })
  }
  
  // MARK: - Methods
  
  public mutating func append(_ value: Element) {
    values.append(value)
  }
  
  public mutating func append(_ value: SQLValueConvertible?) {
    append(value?.sqlValue ?? .null)
  }
  
  public func appending(_ value: Element) -> Arguments {
    var result = self
    result.append(value)
    return result
  }
  
  public func appending(_ value: SQLValueConvertible?) -> Arguments {
    var result = self
    result.append(value)
    return result
  }
  
  public static func + (lhs: Arguments, rhs: Arguments) -> Arguments {
    return Arguments(array: lhs.values + rhs.values)
  }
}

// MARK: - Sequence & IteratorProtocol

extension Arguments: Sequence, IteratorProtocol {
  public func makeIterator() -> Arguments {
    return self
  }
  
  public mutating func next() -> Element? {
    return cursor < values.count ? values[cursor++] : nil
  }
}

// MARK: - ExpressibleByArrayLiteral

extension Arguments: ExpressibleByArrayLiteral {
  public init(arrayLiteral elements: SQLValueConvertible?...) {
    self.init(array: elements)
  }
}
