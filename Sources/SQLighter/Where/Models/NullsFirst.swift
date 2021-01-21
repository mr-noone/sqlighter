import Foundation

struct NullsFirst: SQLRepresentable {
  let nullsFirst: Bool
  var sqlString: String {
    return nullsFirst ? "NULLS FIRST" : "NULLS LAST"
  }
}
