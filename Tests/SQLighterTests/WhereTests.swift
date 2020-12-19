import XCTest
@testable import SQLighter

final class WhereTests: XCTestCase {
  func testWhereClause() {
    let sql = Where().where("id" > 1 && "id" < 5)
    XCTAssertEqual(sql.sqlQuery().sql, "WHERE id > ? AND id < ?")
    XCTAssertEqual(sql.sqlString(), "WHERE id > 1 AND id < 5")
  }
  
  func testWhereAndClause() {
    let sql = Where().where("id" > 1).and("id" < 5)
    XCTAssertEqual(sql.sqlQuery().sql, "WHERE id > ? AND id < ?")
    XCTAssertEqual(sql.sqlString(), "WHERE id > 1 AND id < 5")
  }
  
  func testWhereOrClause() {
    let sql = Where().where("id" > 1).or("id" < 5)
    XCTAssertEqual(sql.sqlQuery().sql, "WHERE id > ? OR id < ?")
    XCTAssertEqual(sql.sqlString(), "WHERE id > 1 OR id < 5")
  }
}
