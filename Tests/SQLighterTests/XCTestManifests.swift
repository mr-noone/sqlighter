import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
  return [
    testCase(SelectTests.allTests),
    testCase(InsertTests.allTests)
  ]
}
#endif
