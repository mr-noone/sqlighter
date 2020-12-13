import Foundation

public enum SQLValue: Equatable {
  case null
  case int(Int64)
  case real(Double)
  case text(String)
  case data(Data)
  
  public var sqlLiteral: String {
    switch self {
    case .null:           return "NULL"
    case .int(let int):   return "\(int)"
    case .real(let real): return "\(real)"
    case .text(let text): return "'\(text)'"
    case .data(let data): return "X'\(data.hex)'"
    }
  }
}
