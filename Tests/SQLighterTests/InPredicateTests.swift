import XCTest
@testable import SQLighter

final class InPredicateTests: XCTestCase {
  func testInPredicate() {
    let predicate = "id" ~= [1, 2, nil]
    XCTAssertEqual(predicate.sqlQuery().sql, "id IN (?, ?, ?)")
    XCTAssertEqual(predicate.sqlString(), "id IN (1, 2, NULL)")
  }
}
