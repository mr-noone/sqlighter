import Foundation

class Constraint: SQLRepresentable {
  // MARK: - Properties
  
  private let name: String?
  
  // MARK: - SQLRepresentable
  
  var sqlString: String {
    self.name != nil ? "CONSTRAINT \(self.name!)" : ""
  }
  
  // MARK: - Inits
  
  init(name: String?) {
    self.name = name
  }
}
