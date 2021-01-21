import Foundation

struct Order: SQLRepresentable {
  let column: SQLColumn
  var ascending: Ascending? = nil
  var nullsFirst: NullsFirst? = nil
  
  var sqlString: String {
    let ascending = self.ascending?.sqlString ?? ""
    let nullsFirst = self.nullsFirst?.sqlString ?? ""
    return [column.sqlString, ascending, nullsFirst]
      .filter { !$0.isEmpty }
      .joined(separator: " ")
  }
}
