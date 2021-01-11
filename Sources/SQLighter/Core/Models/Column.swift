import Foundation

class Column {
  let name: SQLColumn
  let alias: String?
  
  init(name: SQLColumn, as alias: String?) {
    self.name = name
    self.alias = alias
  }
  
  func sqlString(with tableAlias: String?) -> String {
    var name = self.name.sqlString
    if let alias = tableAlias {
      name.insert(contentsOf: ".", at: name.startIndex)
      name.insert(contentsOf: alias, at: name.startIndex)
    }
    if let alias = alias {
      name.append(" AS ")
      name.append(alias)
    }
    return name
  }
}
