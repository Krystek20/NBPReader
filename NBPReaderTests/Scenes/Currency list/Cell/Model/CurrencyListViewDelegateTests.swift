import XCTest
@testable import NBPReader

final class CurrencyListViewDelegateTests: XCTestCase {

    func testCurrencyListViewDelegateCallsDidSelectWhenDidSelectRowAt() {
        // given
        let sut = CurrencyListViewDelegate()
        let expectation = XCTestExpectation()
        sut.didSelect = verify(expectation: expectation, expected: 5)

        // when
        sut.tableView(UITableView(), didSelectRowAt: IndexPath(row: 5, section: .zero))

        // then
        wait(for: [expectation], timeout: 0.01)
    }
}
