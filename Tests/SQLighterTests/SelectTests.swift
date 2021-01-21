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
  
  func testSelectAliasedTableAliasedColumn() {
    let result = "SELECT u.id AS _id FROM User AS u"
    let sql = SQL
      .select(column: "id", as: "_id")
      .from(table: "User", as: "u")
    XCTAssertEqual(sql.sqlString(), result)
  }
  
  func testSelectWhereClause() {
    let sql = SQL.select(from: "User").where("id" == 12)
    XCTAssertEqual(sql.sqlQuery().sql, "SELECT * FROM User WHERE id = ?")
    XCTAssertEqual(sql.sqlString(), "SELECT * FROM User WHERE id = 12")
  }
  
  func testOrderByColumn() {
    let sql = SQL.select(from: "User").order(by: "id").order(by: "name")
    XCTAssertEqual(sql.sqlQuery().sql, "SELECT * FROM User ORDER BY id, name")
  }
  
  func testOrderAscColumn() {
    let sql = SQL.select(from: "User").order(by: "id").ascending().order(by: "name").ascending()
    XCTAssertEqual(sql.sqlQuery().sql, "SELECT * FROM User ORDER BY id ASC, name ASC")
  }
  
  func testOrderDescColumn() {
    let sql = SQL.select(from: "User").order(by: "id").descending().order(by: "name").descending()
    XCTAssertEqual(sql.sqlQuery().sql, "SELECT * FROM User ORDER BY id DESC, name DESC")
  }
  
  func testOrderNullsFirst() {
    let sql = SQL.select(from: "User").order(by: "id").nullsFirst().order(by: "name").nullsFirst()
    XCTAssertEqual(sql.sqlQuery().sql, "SELECT * FROM User ORDER BY id NULLS FIRST, name NULLS FIRST")
  }
  
  func testOrderNullsLast() {
    let sql = SQL.select(from: "User").order(by: "id").nullsLast().order(by: "name").nullsLast()
    XCTAssertEqual(sql.sqlQuery().sql, "SELECT * FROM User ORDER BY id NULLS LAST, name NULLS LAST")
  }
  
  func testOrderAnyColumn() {
    let sql = SQL.select(from: "User").order(by: "id").ascending().nullsFirst().order(by: "name").descending().nullsLast()
    XCTAssertEqual(sql.sqlQuery().sql, "SELECT * FROM User ORDER BY id ASC NULLS FIRST, name DESC NULLS LAST")
  }
  
  func testLimitSelect() {
    let sql = SQL.select(column: "id").from(table: "User").limit(10)
    XCTAssertEqual(sql.sqlQuery().sql, "SELECT id FROM User LIMIT 10")
    XCTAssertEqual(sql.sqlString(), "SELECT id FROM User LIMIT 10")
  }
  
  func testOffsetSelect() {
    let sql = SQL.select(from: "User").limit(10, offset: 20)
    XCTAssertEqual(sql.sqlQuery().sql, "SELECT * FROM User LIMIT 10 OFFSET 20")
    XCTAssertEqual(sql.sqlString(), "SELECT * FROM User LIMIT 10 OFFSET 20")
  }
  
  func testSelectCountColumn() {
    let sql = SQL.count(column: "id", as: "_id", distinct: false).from(table: "User", as: "u")
    XCTAssertEqual(sql.sqlString(), "SELECT count(ALL u.id) AS _id FROM User AS u")
  }
  
  func testSelectCount() {
    let sql = SQL.count(from: "User")
    XCTAssertEqual(sql.sqlString(), "SELECT count(*) FROM User")
  }
  
  func testSelectMultipleCountColumn() {
    let sql = SQL.count(column: "id").count("name").from(table: "User")
    XCTAssertEqual(sql.sqlString(), "SELECT count(ALL id), count(ALL name) FROM User")
  }
}
