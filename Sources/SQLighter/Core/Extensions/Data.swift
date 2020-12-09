import Foundation

extension Data {
  var hex: String {
    map { String(format: "%02hhX", $0) }.joined()
  }
}
