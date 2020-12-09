import Foundation

public enum SQLValue: Equatable {
  case null
  case int(Int64)
  case real(Double)
  case text(String)
  case data(Data)
}
