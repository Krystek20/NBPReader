import XCTest
@testable import NBPReader

final class CurrencyListViewDataSourceTests: XCTestCase {

    private var sut: CurrencyListViewDataSource!

    override func setUp() {
        super.setUp()
        sut = CurrencyListViewDataSource()
        sut.data = [CurrencyCellData(value: .mid(value: 0.1), effectiveDate: "2020-10-30", displayName: nil)]
    }

    override func tearDown() {
        super.tearDown()
    }

    func testCurrencyListViewDataSourceReturnCount() {
        // when
        let count = sut.tableView(UITableView(), numberOfRowsInSection: .zero)

        // then
        XCTAssertEqual(count, 1)
    }

    func testCurrencyListViewDataSourceReturnCell() {
        // given
        let tableView = UITableView()
        tableView.register(CurrencyRowCellView.self)

        // when
        let cell = sut.tableView(tableView, cellForRowAt: IndexPath(row: .zero, section: .zero))

        // then
        XCTAssertTrue(cell is CurrencyRowCellView)
    }
}
