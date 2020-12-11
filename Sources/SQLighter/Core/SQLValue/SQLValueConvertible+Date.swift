import Foundation

extension DateFormatter {
  static var iso8601: DateFormatter {
    let formatter = DateFormatter()
    formatter.locale = Locale(identifier: "en_US_POSIX")
    formatter.timeZone = TimeZone(secondsFromGMT: 0)
    formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
    return formatter
  }
}

public extension SQLValueConvertible where Self == Date {
  var sqlValue: SQLValue { .text(DateFormatter.iso8601.string(from: self)) }
  var sqlLiteral: String { "'\(DateFormatter.iso8601.string(from: self))'" }
  
  init?(_ sqlValue: SQLValue) {
    guard
      case let SQLValue.text(value) = sqlValue,
      let date = DateFormatter.iso8601.date(from: value)
    else {
      return nil
    }
    
    self = date
  }
}

extension Date: SQLValueConvertible {}
