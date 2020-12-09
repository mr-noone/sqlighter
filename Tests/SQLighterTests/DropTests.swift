import XCTest
@testable import SQLighter

final class DropTests: XCTestCase {
  func testDropTable() {
    let sql = SQL.drop(table: "User")
    XCTAssertEqual(sql.sqlString(), "DROP TABLE User")
  }
  
  func testDropTableIfExists() {
    let sql = SQL.drop(table: "User").ifExists()
    XCTAssertEqual(sql.sqlString(), "DROP TABLE IF EXISTS User")
  }
}
