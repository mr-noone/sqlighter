import XCTest
@testable import SQLighter

final class ComparisonPredicateTests: XCTestCase {
  func testEqualPredicate() {
    let predicate = "id" == 123
    XCTAssertEqual(predicate.sqlQuery().sql, "id = ?")
    XCTAssertEqual(predicate.sqlString(), "id = 123")
  }
  
  func testExpressionEqualPredicate() {
    let predicate = "id" == SQL.select(column: "test_id").from(table: "User").limit(1)
    XCTAssertEqual(predicate.sqlQuery().sql, "id = (SELECT test_id FROM User LIMIT 1)")
    XCTAssertEqual(predicate.sqlString(), "id = (SELECT test_id FROM User LIMIT 1)")
  }
  
  func testNotEqualPredicate() {
    let predicate: Predicate = "id" != "str"
    XCTAssertEqual(predicate.sqlQuery().sql, "id != ?")
    XCTAssertEqual(predicate.sqlString(), "id != 'str'")
  }
  
  func testExpressionNotEqualPredicate() {
    let predicate = "id" != SQL.select(column: "test_id").from(table: "User").limit(1)
    XCTAssertEqual(predicate.sqlQuery().sql, "id != (SELECT test_id FROM User LIMIT 1)")
    XCTAssertEqual(predicate.sqlString(), "id != (SELECT test_id FROM User LIMIT 1)")
  }
  
  func testLessThanPredicate() {
    let predicate = "id" < 11
    XCTAssertEqual(predicate.sqlQuery().sql, "id < ?")
    XCTAssertEqual(predicate.sqlString(), "id < 11")
  }
  
  func testExpressionLessThanPredicate() {
    let predicate = "id" < SQL.select(column: "test_id").from(table: "User").limit(1)
    XCTAssertEqual(predicate.sqlQuery().sql, "id < (SELECT test_id FROM User LIMIT 1)")
    XCTAssertEqual(predicate.sqlString(), "id < (SELECT test_id FROM User LIMIT 1)")
  }
  
  func testGreaterThanPredicate() {
    let predicate: Predicate = "id" > "abc"
    XCTAssertEqual(predicate.sqlQuery().sql, "id > ?")
    XCTAssertEqual(predicate.sqlString(), "id > 'abc'")
  }
  
  func testExpressionGreaterThanPredicate() {
    let predicate = "id" > SQL.select(column: "test_id").from(table: "User").limit(1)
    XCTAssertEqual(predicate.sqlQuery().sql, "id > (SELECT test_id FROM User LIMIT 1)")
    XCTAssertEqual(predicate.sqlString(), "id > (SELECT test_id FROM User LIMIT 1)")
  }
  
  func testLessThanOrEqualPredicate() {
    let predicate = "id" <= nil
    XCTAssertEqual(predicate.sqlQuery().sql, "id <= ?")
    XCTAssertEqual(predicate.sqlString(), "id <= NULL")
  }
  
  func testExpressionLessThanOrEqualPredicate() {
    let predicate = "id" <= SQL.select(column: "test_id").from(table: "User").limit(1)
    XCTAssertEqual(predicate.sqlQuery().sql, "id <= (SELECT test_id FROM User LIMIT 1)")
    XCTAssertEqual(predicate.sqlString(), "id <= (SELECT test_id FROM User LIMIT 1)")
  }
  
  func testGreaterThanOrEqualPredicate() {
    let predicate = "id" >= 123
    XCTAssertEqual(predicate.sqlQuery().sql, "id >= ?")
    XCTAssertEqual(predicate.sqlString(), "id >= 123")
  }
  
  func testExpressionGreaterThanOrEqualPredicate() {
    let predicate = "id" >= SQL.select(column: "test_id").from(table: "User").limit(1)
    XCTAssertEqual(predicate.sqlQuery().sql, "id >= (SELECT test_id FROM User LIMIT 1)")
    XCTAssertEqual(predicate.sqlString(), "id >= (SELECT test_id FROM User LIMIT 1)")
  }
}
