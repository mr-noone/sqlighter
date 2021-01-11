import Foundation

class CountColumn: Column {
  let distinct: Bool
  
  init(name: SQLColumn, as alias: String?, distinct: Bool) {
    self.distinct = distinct
    super.init(name: name, as: alias)
  }
  
  override func sqlString(with tableAlias: String?) -> String {
    let alias = self.alias != nil ? " AS \(self.alias!)" : ""
    
    if name.sqlString == "*" {
      return "count(*)\(alias)"
    } else {
      let distinct = self.distinct ? "DISTINCT" : "ALL"
      let column = [tableAlias, name.sqlString].compactMap { $0 }.joined(separator: ".")
      return "count(\(distinct) \(column))\(alias)"
    }
  }
}
