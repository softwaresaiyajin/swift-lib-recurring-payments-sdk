import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(PayseraRecurringPaymentsSDKTests.allTests),
    ]
}
#endif
