import XCTest
@testable import SQLighter

final class SelectTests: XCTestCase {
  static var allTests = [
    ("testSelectAll", testSelectAll),
    ("testSelectAllAliased", testSelectAllAliased),
    ("testSelectColumn", testSelectColumn),
    ("testSelectColumnAliased", testSelectColumnAliased),
    ("testSelectAliasedTable", testSelectAliasedTable)
  ]
  
  func testSelectAll() {
    let result = "SELECT * FROM User"
    let sql = SQL.select(from: "User")
    XCTAssertEqual(sql.trim(), result)
  }
  
  func testSelectAllAliased() {
    let result = "SELECT u.* FROM User AS u"
    let sql = SQL.select(from: "User", as: "u")
    XCTAssertEqual(sql.trim(), result)
  }
  
  func testSelectColumn() {
    let result = "SELECT id, name FROM User"
    let sql = SQL
      .select(column: "id")
      .column("name")
      .from(table: "User")
    XCTAssertEqual(sql.trim(), result)
  }
  
  func testSelectColumnAliased() {
    let result = "SELECT id AS _id, name AS _name FROM User"
    let sql = SQL
      .select(column: "id", as: "_id")
      .column("name", as: "_name")
      .from(table: "User")
    XCTAssertEqual(sql.trim(), result)
  }
  
  func testSelectAliasedTable() {
    let result = "SELECT u.id FROM User AS u"
    let sql = SQL
      .select(column: "id")
      .from(table: "User", as: "u")
    XCTAssertEqual(sql.trim(), result)
  }
}
