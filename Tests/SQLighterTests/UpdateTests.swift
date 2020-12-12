import XCTest
@testable import SQLighter

final class UpdateTests: XCTestCase {
  func testUpdate() {
    let sql = SQL.update(table: "User").column("id", "name").values(11, "John").where("id" < 12).and("id" > 14)
    XCTAssertEqual(sql.sqlQuery().sql, "UPDATE User SET id = ?, name = ? WHERE id < ? AND id > ?")
    XCTAssertEqual(sql.sqlString(), "UPDATE User SET id = 11, name = 'John' WHERE id < 12 AND id > 14")
  }
  
  func testUpdateWithoutValues() {
    let sql = SQL.update(table: "User").column("id", "name").where("id" == 11)
    XCTAssertEqual(sql.sqlQuery().sql, "UPDATE User SET id = ?, name = ? WHERE id = ?")
    XCTAssertEqual(sql.sqlString(), "UPDATE User SET id = ?, name = ? WHERE id = ?")
  }
}
