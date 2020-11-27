import XCTest
@testable import SQLighter

final class DeleteTests: XCTestCase {
  func testDeleteQuery() {
    let sql = SQL.delete(from: "User")
    XCTAssertEqual(sql.sqlString(), "DELETE FROM User")
  }
  
  func testDeleteWhereClause() {
    let sql = SQL.delete(from: "User").where("id" == 1)
    XCTAssertEqual(sql.sqlQuery().sql, "DELETE FROM User WHERE id = ?")
    XCTAssertEqual(sql.sqlString(), "DELETE FROM User WHERE id = 1")
  }
}
