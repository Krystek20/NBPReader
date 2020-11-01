import XCTest

extension XCTestCase {

    func verifySuccessResult<T: Equatable>(_ result: Result<T, Error>, expected: T) {
        switch result {
        case .success(let currencyTable):
            XCTAssertEqual(currencyTable, expected)
        case .failure:
            XCTFail()
        }
    }

    func verifyFailureResult<T: Equatable>(_ result: Result<T, Error>, expected: Error) {
        switch result {
        case .success:
            XCTFail()
        case .failure(let error):
            XCTAssertEqual(error.localizedDescription, expected.localizedDescription)
        }
    }

    func verify(expectation: XCTestExpectation) -> () -> Void {
        expectation.expectedFulfillmentCount = 1
        return {
            expectation.fulfill()
        }
    }

    func verify<T: Equatable>(expectation: XCTestExpectation, expected: T) -> (T) -> Void {
        expectation.expectedFulfillmentCount = 1
        return { result in
            XCTAssertEqual(result, expected)
            expectation.fulfill()
        }
    }

    func verifyNotEquable<T, D: Equatable>(expectation: XCTestExpectation, expected: D) -> (T) -> Void {
        expectation.expectedFulfillmentCount = 1
        return { result in
            XCTAssertEqual(result as? D, expected)
            expectation.fulfill()
        }
    }

    func verify<T: Equatable>(expectation: XCTestExpectation, expected: [T], count: Int) -> (T) -> Void {
        var counter = Int.zero
        expectation.expectedFulfillmentCount = count
        return { result in
            XCTAssertEqual(result, expected[counter])
            expectation.fulfill()
            counter += 1
        }
    }

    func verify(expectation: XCTestExpectation, count: Int) -> () -> Void {
        expectation.expectedFulfillmentCount = count
        return {
            expectation.fulfill()
        }
    }

    func verifyNotCall<T>(expectation: XCTestExpectation) -> (T) -> Void {
        expectation.isInverted = true
        return { _ in
            expectation.fulfill()
        }
    }
}
