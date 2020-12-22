import XCTest
@testable import SQLighter

final class InPredicateTests: XCTestCase {
  func testInPredicate() {
    let predicate = "id" ~= [1, 2, nil]
    XCTAssertEqual(predicate.sqlQuery().sql, "id IN (?, ?, ?)")
    XCTAssertEqual(predicate.sqlString(), "id IN (1, 2, NULL)")
  }
  
  func testExpressionInPredicate() {
    let predicate = "id" ~= SQL.select(column: "test_id").from(table: "User").where("user_id" == 11 && "user_id" != 12)
    XCTAssertEqual(predicate.sqlQuery().sql, "id IN (SELECT test_id FROM User WHERE user_id = ? AND user_id != ?)")
    XCTAssertEqual(predicate.sqlString(), "id IN (SELECT test_id FROM User WHERE user_id = 11 AND user_id != 12)")
  }
}
