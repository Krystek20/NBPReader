import XCTest
@testable import NBPReader

final class DateProviderTests: XCTestCase {

    private var sut: DateProviding!
    private var initialDate: Date!

    override func setUp() {
        super.setUp()
        initialDate = Date()
        sut = DateProvider(initialDate: initialDate)
    }

    override func tearDown() {
        super.tearDown()
        sut = nil
    }

    func testDateProviderReturnFromDateOneDayLess() {
        // given
        let expected = Calendar.current.date(byAdding: .day, value: -1, to: initialDate) ?? initialDate

        // then
        XCTAssertEqual(sut.fromDate, expected)
    }

    func testDateProviderReturnToDateTheSame() throws {
        // then
        XCTAssertEqual(sut.toDate, initialDate)
    }

    func testDateProviderReturnFromDateOneDayLessWhenSetFromGreaterThenToDate() throws {
        // given
        let expected = Calendar.current.date(byAdding: .day, value: -1, to: initialDate)
        let newDate = Calendar.current.date(byAdding: .day, value: 1, to: initialDate)

        // when
        sut.setFromDate(try XCTUnwrap(newDate))

        // then
        XCTAssertEqual(sut.fromDate, expected)
    }

    func testDateProviderReturnFromDateOneYearLessWhenSetFromLessThenOneYear() throws {
        // given
        let expected = Calendar.current.date(byAdding: .year, value: -1, to: initialDate)
        let newDate = Calendar.current.date(byAdding: .year, value: -2, to: initialDate)

        // when
        sut.setFromDate(try XCTUnwrap(newDate))

        // then
        XCTAssertEqual(sut.fromDate, expected)
    }

    func testDateProviderReturnCallsFromDateSetWhenLoadDates() {
        // given
        let expectation = XCTestExpectation()
        let expected = Calendar.current.date(byAdding: .day, value: -1, to: initialDate)
        sut.fromDateSet = verify(expectation: expectation, expected: expected)

        // when
        sut.loadDates()

        // then
        wait(for: [expectation], timeout: 0.01)
    }

    func testDateProviderReturnCallsToDateSetWhenLoadDates() {
        // given
        let expectation = XCTestExpectation()
        sut.toDateSet = verify(expectation: expectation, expected: initialDate)

        // when
        sut.loadDates()

        // then
        wait(for: [expectation], timeout: 0.01)
    }

    func testDateProviderReturnCallsFromDateSetWhenSetFromDate() throws {
        // given
        let expectation = XCTestExpectation()
        let expected = Calendar.current.date(byAdding: .day, value: -3, to: initialDate)
        sut.fromDateSet = verify(expectation: expectation, expected: expected)

        // when
        sut.setFromDate(try XCTUnwrap(expected))

        // then
        wait(for: [expectation], timeout: 0.01)
    }

    func testDateProviderReturnCallsToDateSetWhenSetToDate() throws {
        // given
        let expectation = XCTestExpectation()
        let expected = Calendar.current.date(byAdding: .day, value: 3, to: initialDate)
        sut.toDateSet = verify(expectation: expectation, expected: expected)

        // when
        sut.setToDate(try XCTUnwrap(expected))

        // then
        wait(for: [expectation], timeout: 0.01)
    }

    func testDateProviderReturnCallsFromDateSetWhenSetToDateWhenToDateLessThenFromDate() throws {
        // given
        let expectation = XCTestExpectation()
        let newDate = Calendar.current.date(byAdding: .day, value: -2, to: initialDate)
        let expected = Calendar.current.date(byAdding: .day, value: -3, to: initialDate)
        sut.fromDateSet = verify(expectation: expectation, expected: expected)

        // when
        sut.setToDate(try XCTUnwrap(newDate))

        // then
        wait(for: [expectation], timeout: 0.01)
    }
}
