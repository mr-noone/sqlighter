import Foundation

struct Ascending: SQLRepresentable {
  let ascending: Bool
  var sqlString: String {
    return ascending ? "ASC" : "DESC"
  }
}
