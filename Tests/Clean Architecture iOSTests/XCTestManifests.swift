import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(Clean_Architecture_iOSTests.allTests),
    ]
}
#endif
