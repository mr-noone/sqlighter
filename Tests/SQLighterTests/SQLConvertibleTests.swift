import XCTest
import SQLighter

final class SQLConvertibleTests: XCTestCase {
  func testIntSQLValue() {
    XCTAssertEqual(SQLValue.int(12), Int(12).sqlValue)
    XCTAssertEqual(SQLValue.int(12), Int8(12).sqlValue)
    XCTAssertEqual(SQLValue.int(12), Int16(12).sqlValue)
    XCTAssertEqual(SQLValue.int(12), Int32(12).sqlValue)
    XCTAssertEqual(SQLValue.int(12), Int64(12).sqlValue)
  }
  
  func testIntSQLString() {
    XCTAssertEqual(Int(12).sqlLiteral, "12")
    XCTAssertEqual(Int8(12).sqlLiteral, "12")
    XCTAssertEqual(Int16(12).sqlLiteral, "12")
    XCTAssertEqual(Int32(12).sqlLiteral, "12")
    XCTAssertEqual(Int64(12).sqlLiteral, "12")
  }
  
  func testUIntSQLValue() {
    XCTAssertEqual(SQLValue.int(22), UInt(22).sqlValue)
    XCTAssertEqual(SQLValue.int(22), UInt8(22).sqlValue)
    XCTAssertEqual(SQLValue.int(22), UInt16(22).sqlValue)
    XCTAssertEqual(SQLValue.int(22), UInt32(22).sqlValue)
    XCTAssertEqual(SQLValue.int(22), UInt64(22).sqlValue)
  }
  
  func testUIntSQLString() {
    XCTAssertEqual(UInt(22).sqlLiteral, "22")
    XCTAssertEqual(UInt8(22).sqlLiteral, "22")
    XCTAssertEqual(UInt16(22).sqlLiteral, "22")
    XCTAssertEqual(UInt32(22).sqlLiteral, "22")
    XCTAssertEqual(UInt64(22).sqlLiteral, "22")
  }
  
  func testRealSQLValue() {
    XCTAssertEqual(SQLValue.real(Double(Float(3.2))), Float(3.2).sqlValue)
    XCTAssertEqual(SQLValue.real(3.2), Double(3.2).sqlValue)
  }
  
  func testRealSQLString() {
    XCTAssertEqual(Float(3.2).sqlLiteral, "3.2")
    XCTAssertEqual(Double(3.2).sqlLiteral, "3.2")
  }
  
  func testBoolSQLValue() {
    XCTAssertEqual(SQLValue.int(1), true.sqlValue)
    XCTAssertEqual(SQLValue.int(0), false.sqlValue)
  }
  
  func testBoolSQLString() {
    XCTAssertEqual(true.sqlLiteral, "1")
    XCTAssertEqual(false.sqlLiteral, "0")
  }
  
  func testTextSQLValue() {
    XCTAssertEqual(SQLValue.text("str"), "str".sqlValue)
  }
  
  func testTextSQLString() {
    XCTAssertEqual("str".sqlLiteral, "'str'")
  }
  
  func testDataSQLValue() {
    let data = "test data".data(using: .utf8)!
    XCTAssertEqual(SQLValue.data(data), data.sqlValue)
  }
  
  func testDataSQLString() {
    let data = "test data".data(using: .utf8)!
    XCTAssertEqual(data.sqlLiteral, "X'746573742064617461'")
  }
}
