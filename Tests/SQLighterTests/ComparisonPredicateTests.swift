import XCTest
@testable import SQLighter

final class ComparisonPredicateTests: XCTestCase {
  func testEqualPredicate() {
    let predicate = "id" == 123
    XCTAssertEqual(predicate.sqlQuery().sql, "id = ?")
    XCTAssertEqual(predicate.sqlString(), "id = 123")
  }
  
  func testNotEqualPredicate() {
    let predicate: Predicate = "id" != "str"
    XCTAssertEqual(predicate.sqlQuery().sql, "id != ?")
    XCTAssertEqual(predicate.sqlString(), "id != 'str'")
  }
  
  func testLessThanPredicate() {
    let predicate = "id" < 11
    XCTAssertEqual(predicate.sqlQuery().sql, "id < ?")
    XCTAssertEqual(predicate.sqlString(), "id < 11")
  }
  
  func testGreaterThanPredicate() {
    let predicate: Predicate = "id" > "abc"
    XCTAssertEqual(predicate.sqlQuery().sql, "id > ?")
    XCTAssertEqual(predicate.sqlString(), "id > 'abc'")
  }
  
  func testLessThanOrEqualPredicate() {
    let predicate = "id" <= nil
    XCTAssertEqual(predicate.sqlQuery().sql, "id <= ?")
    XCTAssertEqual(predicate.sqlString(), "id <= NULL")
  }
  
  func testGreaterThanOrEqualPredicate() {
    let predicate = "id" >= 123
    XCTAssertEqual(predicate.sqlQuery().sql, "id >= ?")
    XCTAssertEqual(predicate.sqlString(), "id >= 123")
  }
}
