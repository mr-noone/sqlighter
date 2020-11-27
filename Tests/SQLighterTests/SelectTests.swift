import XCTest
@testable import SQLighter

final class SelectTests: XCTestCase {
  func testSelectAll() {
    let result = "SELECT * FROM User"
    let sql = SQL.select(from: "User")
    XCTAssertEqual(sql.sqlString(), result)
  }
  
  func testSelectAllAliased() {
    let result = "SELECT u.* FROM User AS u"
    let sql = SQL.select(from: "User", as: "u")
    XCTAssertEqual(sql.sqlString(), result)
  }
  
  func testSelectColumn() {
    let result = "SELECT id, name FROM User"
    let sql = SQL
      .select(column: "id")
      .column("name")
      .from(table: "User")
    XCTAssertEqual(sql.sqlString(), result)
  }
  
  func testSelectColumnAliased() {
    let result = "SELECT id AS _id, name AS _name FROM User"
    let sql = SQL
      .select(column: "id", as: "_id")
      .column("name", as: "_name")
      .from(table: "User")
    XCTAssertEqual(sql.sqlString(), result)
  }
  
  func testSelectAliasedTable() {
    let result = "SELECT u.id FROM User AS u"
    let sql = SQL
      .select(column: "id")
      .from(table: "User", as: "u")
    XCTAssertEqual(sql.sqlString(), result)
  }
  
  func testSelectWhereClause() {
    let sql = SQL.select(from: "User").where("id" == 12)
    XCTAssertEqual(sql.sqlQuery().sql, "SELECT * FROM User WHERE id = ?")
    XCTAssertEqual(sql.sqlString(), "SELECT * FROM User WHERE id = 12")
  }
}
