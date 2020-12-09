import XCTest
@testable import SQLighter

final class InsertTests: XCTestCase {
  func testInsertSingleRowWithoutColumns() {
    let sql = SQL
      .insert(into: "User")
      .values(1, "abc")
    
    XCTAssertEqual(sql.sqlString(), "INSERT INTO User VALUES (1, 'abc')")
    XCTAssertEqual(sql.sqlQuery().sql, "INSERT INTO User VALUES (?, ?)")
  }
  
  func testInsertMultipleRowsWithoutColumns() {
    let sql = SQL
      .insert(into: "User")
      .values(1, "abc")
      .values(2, "xyz")
    
    XCTAssertEqual(sql.sqlString(), "INSERT INTO User VALUES (1, 'abc'), (2, 'xyz')")
    XCTAssertEqual(sql.sqlQuery().sql, "INSERT INTO User VALUES (?, ?), (?, ?)")
  }
  
  func testInsertSingleRowWithColumns() {
    let sql = SQL
      .insert(into: "User")
      .column("id", "name")
      .values(1, "abc")
    
    XCTAssertEqual(sql.sqlString(), "INSERT INTO User (id, name) VALUES (1, 'abc')")
    XCTAssertEqual(sql.sqlQuery().sql, "INSERT INTO User (id, name) VALUES (?, ?)")
  }
  
  func testInsertMultipleRowsWithColumns() {
    let sql = SQL
      .insert(into: "User")
      .column("id", "name")
      .values(1, "abc")
      .values(2, "xyz")
    
    XCTAssertEqual(sql.sqlString(), "INSERT INTO User (id, name) VALUES (1, 'abc'), (2, 'xyz')")
    XCTAssertEqual(sql.sqlQuery().sql, "INSERT INTO User (id, name) VALUES (?, ?), (?, ?)")
  }
  
  func testInsertNullValues() {
    let sql = SQL
      .insert(into: "User")
      .column("id", "name")
      .values(nil, "abc")
    
    XCTAssertEqual(sql.sqlString(), "INSERT INTO User (id, name) VALUES (NULL, 'abc')")
    XCTAssertEqual(sql.sqlQuery().sql, "INSERT INTO User (id, name) VALUES (?, ?)")
  }
}
