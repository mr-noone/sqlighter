import XCTest
@testable import SQLighter

final class BetweenPredicateTests: XCTestCase {
  func testBetweenPredicate() {
    let predicate = "id" ~= 0...100
    XCTAssertEqual(predicate.sqlQuery().sql, "id BETWEEN ? AND ?")
    XCTAssertEqual(predicate.sqlString(), "id BETWEEN 0 AND 100")
  }
  
  func testNotBetweenPredicate() {
    let predicate = "id" != "a"..."z"
    XCTAssertEqual(predicate.sqlQuery().sql, "id NOT BETWEEN ? AND ?")
    XCTAssertEqual(predicate.sqlString(), "id NOT BETWEEN 'a' AND 'z'")
  }
}
