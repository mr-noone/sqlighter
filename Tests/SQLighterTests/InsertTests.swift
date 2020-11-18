import XCTest
@testable import SQLighter

final class InsertTests: XCTestCase {
  static var allTests = [
    ("testInsertSingleRowWithoutColumns", testInsertSingleRowWithoutColumns),
    ("testInsertMultipleRowsWithoutColumns", testInsertMultipleRowsWithoutColumns),
    ("testInsertSingleRowWithColumns", testInsertSingleRowWithColumns),
    ("testInsertMultipleRowsWithColumns", testInsertMultipleRowsWithColumns),
    ("testInsertNullValues", testInsertNullValues)
  ]
  
  func testInsertSingleRowWithoutColumns() {
    let result = "INSERT INTO User VALUES (1, 'abc')"
    let sql = SQL
      .insert(into: "User")
      .values(1, "abc")
    XCTAssertEqual(sql.trim(), result)
  }
  
  func testInsertMultipleRowsWithoutColumns() {
    let result = "INSERT INTO User VALUES (1, 'abc'), (2, 'xyz')"
    let sql = SQL
      .insert(into: "User")
      .values(1, "abc")
      .values(2, "xyz")
    XCTAssertEqual(sql.trim(), result)
  }
  
  func testInsertSingleRowWithColumns() {
    let result = "INSERT INTO User (id, name) VALUES (1, 'abc')"
    let sql = SQL
      .insert(into: "User")
      .column("id", "name")
      .values(1, "abc")
    XCTAssertEqual(sql.trim(), result)
  }
  
  func testInsertMultipleRowsWithColumns() {
    let result = "INSERT INTO User (id, name) VALUES (1, 'abc'), (2, 'xyz')"
    let sql = SQL
      .insert(into: "User")
      .column("id", "name")
      .values(1, "abc")
      .values(2, "xyz")
    XCTAssertEqual(sql.trim(), result)
  }
  
  func testInsertNullValues() {
    let result = "INSERT INTO User (id, name) VALUES (NULL, 'abc')"
    let sql = SQL
      .insert(into: "User")
      .column("id", "name")
      .values(nil, "abc")
    XCTAssertEqual(sql.trim(), result)
  }
}
