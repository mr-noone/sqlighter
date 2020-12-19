import XCTest
@testable import SQLighter

final class CreateTests: XCTestCase {
  func testCreateTable() {
    let sql = SQL.create(table: "User").column("id", type: .integer).column("name", type: .text)
    XCTAssertEqual(sql.sqlQuery().sql, "CREATE TABLE User (id INTEGER, name TEXT)")
  }
  
  func testCreateTableIfNotExists() {
    let sql = SQL.create(table: "User").ifNotExists().column("id", type: .integer)
    XCTAssertEqual(sql.sqlQuery().sql, "CREATE TABLE IF NOT EXISTS User (id INTEGER)")
  }
  
  func testCreateTableColumnPrimaryKey() {
    let sql = SQL.create(table: "User").column("id", type: .integer).primaryKey()
    XCTAssertEqual(sql.sqlQuery().sql, "CREATE TABLE User (id INTEGER PRIMARY KEY)")
  }
  
  func testCreateTableColumnPrimaryKeyAutoincrement() {
    let sql = SQL.create(table: "User").column("id", type: .integer).primaryKey(name: "c_pk", autoincrement: true)
    XCTAssertEqual(sql.sqlQuery().sql, "CREATE TABLE User (id INTEGER CONSTRAINT c_pk PRIMARY KEY AUTOINCREMENT)")
  }
  
  func testCreateTableColumnNotNull() {
    let sql = SQL.create(table: "User").column("id", type: .integer).notNull()
    XCTAssertEqual(sql.sqlQuery().sql, "CREATE TABLE User (id INTEGER NOT NULL)")
  }
  
  func testCreateTableColumnNotNullNamed() {
    let sql = SQL.create(table: "User").column("id", type: .integer).notNull(name: "c_nn")
    XCTAssertEqual(sql.sqlQuery().sql, "CREATE TABLE User (id INTEGER CONSTRAINT c_nn NOT NULL)")
  }
  
  func testCreateTableColumnUnique() {
    let sql = SQL.create(table: "User").column("id", type: .integer).unique()
    XCTAssertEqual(sql.sqlQuery().sql, "CREATE TABLE User (id INTEGER UNIQUE)")
  }
  
  func testCreateTableColumnUniqueNamed() {
    let sql = SQL.create(table: "User").column("id", type: .integer).unique(name: "c_uq")
    XCTAssertEqual(sql.sqlQuery().sql, "CREATE TABLE User (id INTEGER CONSTRAINT c_uq UNIQUE)")
  }
  
  func testCreateTableColumnCheck() {
    let sql = SQL.create(table: "User").column("id", type: .integer).check(sql: "id > 0")
    XCTAssertEqual(sql.sqlQuery().sql, "CREATE TABLE User (id INTEGER CHECK (id > 0))")
  }
  
  func testCreateTableColumnCheckNamed() {
    let sql = SQL.create(table: "User").column("id", type: .integer).check(name: "c_ch", sql: "id > 0")
    XCTAssertEqual(sql.sqlQuery().sql, "CREATE TABLE User (id INTEGER CONSTRAINT c_ch CHECK (id > 0))")
  }
  
  func testCreateTableColumnDefaultExpression() {
    let sql = SQL.create(table: "User").column("id", type: .integer).default(sql: "SELECT id FROM Default")
    XCTAssertEqual(sql.sqlQuery().sql, "CREATE TABLE User (id INTEGER DEFAULT (SELECT id FROM Default))")
  }
  
  func testCreateTableColumnDefaultExpressionNamed() {
    let sql = SQL.create(table: "User").column("id", type: .integer).default(name: "c_df", sql: "SELECT id FROM Default")
    XCTAssertEqual(sql.sqlQuery().sql, "CREATE TABLE User (id INTEGER CONSTRAINT c_df DEFAULT (SELECT id FROM Default))")
  }
  
  func testCreateTableColumnDefaultValue() {
    let sql = SQL.create(table: "User").column("id", type: .integer).default(value: 11)
    XCTAssertEqual(sql.sqlQuery().sql, "CREATE TABLE User (id INTEGER DEFAULT 11)")
  }
  
  func testCreateTableColumnDefaultValueNamed() {
    let sql = SQL.create(table: "User").column("id", type: .integer).default(name: "c_df", value: 11)
    XCTAssertEqual(sql.sqlQuery().sql, "CREATE TABLE User (id INTEGER CONSTRAINT c_df DEFAULT 11)")
  }
  
  func testCreateTableColumnReferences() {
    let sql = SQL.create(table: "User").column("profile", type: .integer).references(table: "Profile")
    XCTAssertEqual(sql.sqlQuery().sql, "CREATE TABLE User (profile INTEGER REFERENCES Profile)")
  }
  
  func testCreateTableColumnReferencesNamed() {
    let sql = SQL.create(table: "User").column("profile", type: .integer).references(name: "c_fk", table: "Profile", onDelete: .cascade, onUpdate: .cascade)
    XCTAssertEqual(sql.sqlQuery().sql, "CREATE TABLE User (profile INTEGER CONSTRAINT c_fk REFERENCES Profile ON DELETE CASCADE ON UPDATE CASCADE)")
  }
  
  func testCreateTablePrimaryKey() {
    let sql = SQL.create(table: "User")
      .column("id_1", type: .integer)
      .column("id_2", type: .integer)
      .tablePrimaryKey(columns: "id_1", "id_2")
    let str = "CREATE TABLE User (id_1 INTEGER, id_2 INTEGER, PRIMARY KEY (id_1, id_2))"
    XCTAssertEqual(sql.sqlQuery().sql, str)
  }
  
  func testCreateTablePrimaryKeyNamed() {
    let sql = SQL.create(table: "User")
      .column("id_1", type: .integer)
      .column("id_2", type: .integer)
      .tablePrimaryKey(name: "c_pk", columns: "id_1", "id_2")
    let str = "CREATE TABLE User (id_1 INTEGER, id_2 INTEGER, CONSTRAINT c_pk PRIMARY KEY (id_1, id_2))"
    XCTAssertEqual(sql.sqlQuery().sql, str)
  }
  
  func testCreateTableUnique() {
    let sql = SQL.create(table: "User")
      .column("id_1", type: .integer)
      .column("id_2", type: .integer)
      .tableUnique(columns: "id_1", "id_2")
    let str = "CREATE TABLE User (id_1 INTEGER, id_2 INTEGER, UNIQUE (id_1, id_2))"
    XCTAssertEqual(sql.sqlQuery().sql, str)
  }
  
  func testCreateTableUniqueNamed() {
    let sql = SQL.create(table: "User")
      .column("id_1", type: .integer)
      .column("id_2", type: .integer)
      .tableUnique(name: "c_uq", columns: "id_1", "id_2")
    let str = "CREATE TABLE User (id_1 INTEGER, id_2 INTEGER, CONSTRAINT c_uq UNIQUE (id_1, id_2))"
    XCTAssertEqual(sql.sqlQuery().sql, str)
  }
  
  func testCreateTableCheck() {
    let sql = SQL.create(table: "User").column("id", type: .integer).tableCheck(sql: "id > 0")
    XCTAssertEqual(sql.sqlQuery().sql, "CREATE TABLE User (id INTEGER, CHECK (id > 0))")
  }
  
  func testCreateTableCheckNamed() {
    let sql = SQL.create(table: "User").column("id", type: .integer).tableCheck(name: "c_ch", sql: "id > 0")
    XCTAssertEqual(sql.sqlQuery().sql, "CREATE TABLE User (id INTEGER, CONSTRAINT c_ch CHECK (id > 0))")
  }
  
  func testCreateTableReferences() {
    let sql = SQL.create(table: "User")
      .column("profile", type: .integer)
      .column("userInfo", type: .text)
      .tableReferences(columns: "profile", "userInfo", table: "Profile")
    let str = "CREATE TABLE User (profile INTEGER, userInfo TEXT, FOREIGN KEY (profile, userInfo) REFERENCES Profile)"
    XCTAssertEqual(sql.sqlQuery().sql, str)
  }
  
  func testCreateTableReferencesNamed() {
    let sql = SQL.create(table: "User")
      .column("profile", type: .integer)
      .column("userInfo", type: .text)
      .tableReferences(name: "c_fk", columns: "profile", "userInfo", table: "Profile", onDelete: .cascade, onUpdate: .cascade)
    let str = "CREATE TABLE User (profile INTEGER, userInfo TEXT, CONSTRAINT c_fk FOREIGN KEY (profile, userInfo) REFERENCES Profile ON DELETE CASCADE ON UPDATE CASCADE)"
    XCTAssertEqual(sql.sqlQuery().sql, str)
  }
}
