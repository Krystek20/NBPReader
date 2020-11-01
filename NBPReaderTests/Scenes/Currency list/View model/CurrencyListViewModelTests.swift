import XCTest
@testable import NBPReader

final class CurrencyListViewModelTests: XCTestCase {

    private var sut: CurrencyListViewModelType!
    private var currencyProviderStub: CurrencyListProviderStub!

    override func setUp() {
        super.setUp()
        currencyProviderStub = CurrencyListProviderStub()
        sut = CurrencyListViewModel(currencyProviding: currencyProviderStub)
    }

    override func tearDown() {
        super.tearDown()
        currencyProviderStub = nil
        sut = nil
    }

    func testCurrencyListViewModelCallsStartAnimatingIndicatorWhenStartAnimatingActivityIndicatorConnected() {
        // given
        let expectation = XCTestExpectation()

        // when
        sut.startAnimating = verify(expectation: expectation)

        // then
        wait(for: [expectation], timeout: 0.01)
    }

    func testCurrencyListViewModelCallsStopAnimatingWhenViewDidLoad() {
        // given
        let expectation = XCTestExpectation()
        sut.stopAnimating = verify(expectation: expectation)

        // when
        sut.viewDidLoad()

        // then
        wait(for: [expectation], timeout: 0.01)
    }

    func testCurrencyListViewModelCallsDataLoadedWhenViewDidLoad() {
        // given
        let expectation = XCTestExpectation()
        let expected = CurrencyCellData.cellData(from: CurrencyList.fixture)
        sut.dataLoaded = verify(expectation: expectation, expected: expected)
        
        // when
        sut.viewDidLoad()

        // then
        wait(for: [expectation], timeout: 0.01)
    }

    func testCurrencyListViewModelCallsReloadDataWhenViewDidLoad() {
        // given
        let expectation = XCTestExpectation()
        sut.reloadData = verify(expectation: expectation)

        // when
        sut.viewDidLoad()

        // then
        wait(for: [expectation], timeout: 0.01)
    }

    func testCurrencyListViewModelCallsSegmentItemPreparedWhenConnected() {
        // given
        let expectation = XCTestExpectation()

        // when
        sut.segmentItemPrepared = verify(expectation: expectation, expected: ["Table A", "Table B", "Table C"])

        // then
        wait(for: [expectation], timeout: 0.01)
    }

    func testCurrencyListViewModelCallsStartAnimatingWhenChangeTable() {
        // given
        let expectation = XCTestExpectation()

        // when
        sut.startAnimating = verify(expectation: expectation)

        // then
        sut.changeTable(with: 1)
        wait(for: [expectation], timeout: 0.01)
    }

    func testCurrencyListViewModelCallsDataLoadedWhenChangeTableTwice() {
        // given
        let expectation = XCTestExpectation()
        let expected = CurrencyCellData.cellData(from: CurrencyList.fixture)
        sut.dataLoaded = verify(expectation: expectation, expected: [[], expected], count: 2)

        // when
        sut.changeTable(with: 1)

        // then
        wait(for: [expectation], timeout: 0.01)
    }

    func testCurrencyListViewModelCallsReloadDataWhenChangeTableTwice() {
        // given
        let expectation = XCTestExpectation()
        sut.reloadData = verify(expectation: expectation, count: 2)

        // when
        sut.changeTable(with: 1)

        // then
        wait(for: [expectation], timeout: 0.01)
    }

    func testCurrencyListViewModelCallsStopAnimatingWhenChangeTable() {
        // given
        let expectation = XCTestExpectation()
        sut.stopAnimating = verify(expectation: expectation)

        // when
        sut.changeTable(with: 1)

        // then
        wait(for: [expectation], timeout: 0.01)
    }

    func testCurrencyListViewModelCallsStopAnimatingWhenRefreshData() {
        // given
        let expectation = XCTestExpectation()
        sut.stopAnimating = verify(expectation: expectation)

        // when
        sut.refreshData()

        // then
        wait(for: [expectation], timeout: 0.01)
    }

    func testCurrencyListViewModelCallsDataLoadedWhenRefreshData() {
        // given
        let expectation = XCTestExpectation()
        let expected = CurrencyCellData.cellData(from: CurrencyList.fixture)
        sut.dataLoaded = verify(expectation: expectation, expected: [[], expected], count: 2)

        // when
        sut.refreshData()

        // then
        wait(for: [expectation], timeout: 0.01)
    }

    func testCurrencyListViewModelCallsRefreshDataWhenRefreshData() {
        // given
        let expectation = XCTestExpectation()
        sut.reloadData = verify(expectation: expectation, count: 2)

        // when
        sut.refreshData()

        // then
        wait(for: [expectation], timeout: 0.01)
    }

    func testCurrencyListViewModelCallsCurrencySelectedWhenSelectIndex() {
        // given
        let expectation = XCTestExpectation()
        sut.viewDidLoad()
        let expected = CurrencySelected(currency: .fixtureMidValue, tableName: "A")
        sut.currencySelected = verify(expectation: expectation, expected: expected)

        // when
        sut.select(index: .zero)

        // then
        wait(for: [expectation], timeout: 0.01)
    }

    func testCurrencyListViewModelCallsTitleWhenConnected() {
        // given
        let expectation = XCTestExpectation()

        // when
        sut.title = verify(expectation: expectation, expected: "Currency List")

        // then
        wait(for: [expectation], timeout: 0.01)
    }

    func testCurrencyListViewModelCallsStopAnimatingWhenViewDidLoadWithError() {
        // given
        let expectation = XCTestExpectation()
        currencyProviderStub.error = NetworkingError.emptyData
        sut.stopAnimating = verify(expectation: expectation)

        // when
        sut.viewDidLoad()

        // then
        wait(for: [expectation], timeout: 0.01)
    }

    func testCurrencyListViewModelCallsErrorHandledWhenViewDidLoadWithError() {
        // given
        let expectation = XCTestExpectation()
        currencyProviderStub.error = NetworkingError.emptyData
        sut.errorHandled = verifyNotEquable(expectation: expectation, expected: NetworkingError.emptyData)

        // when
        sut.viewDidLoad()

        // then
        wait(for: [expectation], timeout: 0.01)
    }

    func testCurrencyListViewModelCallsDataLoadedWhenViewDidLoadWithError() {
        // given
        let expectation = XCTestExpectation()
        currencyProviderStub.error = NetworkingError.emptyData
        sut.dataLoaded = verify(expectation: expectation, expected: [])

        // when
        sut.viewDidLoad()

        // then
        wait(for: [expectation], timeout: 0.01)
    }

    func testCurrencyListViewModelCallsReloadDataWhenViewDidLoadWithError() {
        // given
        let expectation = XCTestExpectation()
        currencyProviderStub.error = NetworkingError.emptyData
        sut.reloadData = verify(expectation: expectation)

        // when
        sut.viewDidLoad()

        // then
        wait(for: [expectation], timeout: 0.01)
    }
}
