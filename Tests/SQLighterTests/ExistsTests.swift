import XCTest
@testable import SQLighter

final class ExistsTests: XCTestCase {
  func testExists() {
    let sql = SQL.exists(in: "User").where("id" == 1)
    XCTAssertEqual(sql.sqlQuery().sql, "SELECT EXISTS (SELECT * FROM User WHERE id = ?)")
    XCTAssertEqual(sql.sqlString(), "SELECT EXISTS (SELECT * FROM User WHERE id = 1)")
  }
}
