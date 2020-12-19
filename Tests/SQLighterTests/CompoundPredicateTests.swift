import XCTest
@testable import SQLighter

final class CompoundPredicateTests: XCTestCase {
  func testAndPredicate() {
    let predicate = "id" > 2 && "id" < 10
    XCTAssertEqual(predicate.sqlQuery().sql, "id > ? AND id < ?")
    XCTAssertEqual(predicate.sqlString(), "id > 2 AND id < 10")
  }
  
  func testOrPredicate() {
    let predicate = "id" == 1 || "id" == 12
    XCTAssertEqual(predicate.sqlQuery().sql, "id = ? OR id = ?")
    XCTAssertEqual(predicate.sqlString(), "id = 1 OR id = 12")
  }
  
  func testOrAndPredicate() {
    let predicate = ("id" == 1 || "id" == 2) && "id" != 22
    XCTAssertEqual(predicate.sqlQuery().sql, "(id = ? OR id = ?) AND id != ?")
    XCTAssertEqual(predicate.sqlString(), "(id = 1 OR id = 2) AND id != 22")
  }
  
  func testAndOrPredicate() {
    let predicate = "id" != 22 && ("id" == 1 || "id" == 2)
    XCTAssertEqual(predicate.sqlQuery().sql, "id != ? AND (id = ? OR id = ?)")
    XCTAssertEqual(predicate.sqlString(), "id != 22 AND (id = 1 OR id = 2)")
  }
  
  func testOrAndORPredivate() {
    let predicate = ("id" == 1 || "id" == 2) && ("id" == 1 || "id" == 2)
    XCTAssertEqual(predicate.sqlQuery().sql, "(id = ? OR id = ?) AND (id = ? OR id = ?)")
    XCTAssertEqual(predicate.sqlString(), "(id = 1 OR id = 2) AND (id = 1 OR id = 2)")
  }
  
  func testAndOrAndPredicate() {
    let predicate = "id" == 1 && ("id" == 2 || "id" == 3) && "id" == 4
    XCTAssertEqual(predicate.sqlQuery().sql, "id = ? AND (id = ? OR id = ?) AND id = ?")
    XCTAssertEqual(predicate.sqlString(), "id = 1 AND (id = 2 OR id = 3) AND id = 4")
  }
}
