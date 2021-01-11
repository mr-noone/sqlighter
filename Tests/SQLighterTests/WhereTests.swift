import XCTest
@testable import SQLighter

final class WhereTests: XCTestCase {
  func testWhereClause() {
    let sql = Where().where("id" > 1 && "id" < 5)
    XCTAssertEqual(sql.sqlQuery().sql, "WHERE id > ? AND id < ?")
    XCTAssertEqual(sql.sqlString(), "WHERE id > 1 AND id < 5")
  }
  
  func testWhereExpressionClause() {
    let sql = Where().where(sql: "id < 10 AND id > 20")
    XCTAssertEqual(sql.sqlQuery().sql, "WHERE id < 10 AND id > 20")
  }
  
  func testWhereExpressionArumentsClause() {
    let sql = Where().where(sql: "id < ? AND id > ?", args: 10, 20)
    XCTAssertEqual(sql.sqlQuery().sql, "WHERE id < ? AND id > ?")
    XCTAssertEqual(sql.sqlString(), "WHERE id < 10 AND id > 20")
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
