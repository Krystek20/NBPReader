import XCTest
@testable import NBPReader

final class CurrencyDetailViewModelTests: XCTestCase {

    private var sut: CurrencyDetailViewModelType!
    private var date: Date!
    private var currencyProviderStub: CurrencyListProviderStub!
    private enum FakeError: Error {
        case fakeError
    }

    override func setUp() {
        super.setUp()
        let currencySelected = CurrencySelected(currency: .fixtureMidValue, tableName: "A")
        date = Date()
        currencyProviderStub = CurrencyListProviderStub()
        sut = CurrencyDetailViewModel(
            currencySelected: currencySelected,
            currencyProviding: currencyProviderStub,
            dateProvider: DateProvider(initialDate: date)
        )
    }

    override func tearDown() {
        super.tearDown()
        sut = nil
    }

    func testCurrencyDetailViewModelCallsStartAnimatingWhenStartAnimatingConnected() {
        // given
        let expectation = XCTestExpectation()

        // when
        sut.startAnimating = verify(expectation: expectation)

        // then
        wait(for: [expectation], timeout: 0.01)
    }

    func testCurrencyDetailViewModelCallsFromDateSetWhenFromDateSetConnected() {
        // given
        let expectation = XCTestExpectation()

        // when
        let expected = Calendar.current.date(byAdding: .day, value: -1, to: date) ?? date
        sut.fromDateSet = verify(expectation: expectation, expected: expected)

        // then
        wait(for: [expectation], timeout: 0.01)
    }

    func testCurrencyDetailViewModelCallsToDateSetWhenToDateSetConnected() {
        // given
        let expectation = XCTestExpectation()

        // when
        sut.toDateSet = verify(expectation: expectation, expected: date)

        // then
        wait(for: [expectation], timeout: 0.01)
    }

    func testCurrencyDetailViewModelCallsDataLoadedWhenViewDidLoad() {
        // given
        let expectation = XCTestExpectation()
        let expected = CurrencyCellData.cellData(from: CurrencyDetailList.fixture)
        sut.dataLoaded = verify(expectation: expectation, expected: expected)

        // when
        sut.viewDidLoad()

        // then
        wait(for: [expectation], timeout: 0.01)
    }

    func testCurrencyDetailViewModelCallsStopAnimatingWhenViewDidLoad() {
        // given
        let expectation = XCTestExpectation()
        sut.stopAnimating = verify(expectation: expectation)

        // when
        sut.viewDidLoad()

        // then
        wait(for: [expectation], timeout: 0.01)
    }

    func testCurrencyDetailViewModelCallsReloadDataWhenViewDidLoad() {
        // given
        let expectation = XCTestExpectation()
        sut.reloadData = verify(expectation: expectation)

        // when
        sut.viewDidLoad()

        // then
        wait(for: [expectation], timeout: 0.01)
    }

    func testCurrencyDetailViewModelCallsFromDateSetWhenViewDidLoad() {
        // given
        let expectation = XCTestExpectation()
        let expected = Calendar.current.date(byAdding: .day, value: -1, to: date) ?? date
        sut.fromDateSet = verify(expectation: expectation, expected: expected)

        // when
        sut.viewDidLoad()

        // then
        wait(for: [expectation], timeout: 0.01)
    }

    func testCurrencyDetailViewModelCallsToDateSetWhenViewDidLoad() {
        // given
        let expectation = XCTestExpectation()
        sut.toDateSet = verify(expectation: expectation, expected: date)

        // when
        sut.viewDidLoad()

        // then
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testCurrencyDetailViewModelCallsErrorHandledWhenViewDidLoad() {
        // given
        let expectation = XCTestExpectation()
        currencyProviderStub.error = FakeError.fakeError
        sut.errorHandled = verifyNotEquable(expectation: expectation, expected: FakeError.fakeError)

        // when
        sut.viewDidLoad()

        // then
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testCurrencyDetailViewModelCallsStopAnimatingWhenViewDidLoadWithError() {
        // given
        let expectation = XCTestExpectation()
        currencyProviderStub.error = FakeError.fakeError
        sut.stopAnimating = verify(expectation: expectation)

        // when
        sut.viewDidLoad()

        // then
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testCurrencyDetailViewModelCallsDataLoadedWhenViewDidLoadWithError() {
        // given
        let expectation = XCTestExpectation()
        currencyProviderStub.error = FakeError.fakeError
        sut.dataLoaded = verify(expectation: expectation, expected: [])

        // when
        sut.viewDidLoad()

        // then
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testCurrencyDetailViewModelCallsReloadDataWhenViewDidLoadWithError() {
        // given
        let expectation = XCTestExpectation()
        currencyProviderStub.error = FakeError.fakeError
        sut.reloadData = verify(expectation: expectation)

        // when
        sut.viewDidLoad()

        // then
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testCurrencyDetailViewModelNotCallsErrorHandledWhenViewDidLoadAndErrorEmptyList() {
        // given
        let expectation = XCTestExpectation()
        currencyProviderStub.error = NetworkingError.emptyList
        sut.errorHandled = verifyNotCall(expectation: expectation)

        // when
        sut.viewDidLoad()

        // then
        wait(for: [expectation], timeout: 0.01)
    }

    func testCurrencyDetailViewModelCallsSetupFromTextWhenSetFromDate() {
        // given
        let expectation = XCTestExpectation()
        let timePeriodProvider = TimePeriodProvider()
        let newDate = Calendar.current.date(byAdding: .day, value: -2, to: date) ?? Date()
        let expected = timePeriodProvider.stringValue(from: newDate)
        sut.fromTextSet = verify(expectation: expectation, expected: expected)

        // when
        sut.setFromDate(newDate)

        // then
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testCurrencyDetailViewModelCallsFromDateSetWhenSetFromDate() {
        // given
        let expectation = XCTestExpectation()
        let initialDate = Calendar.current.date(byAdding: .day, value: -1, to: date) ?? Date()
        let newDate = Calendar.current.date(byAdding: .day, value: -2, to: date) ?? Date()
        sut.fromDateSet = verify(expectation: expectation, expected: [initialDate, newDate], count: 2)

        // when
        sut.setFromDate(newDate)

        // then
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testCurrencyDetailViewModelCallsSetupToTextWhenSetToDate() {
        // given
        let expectation = XCTestExpectation()
        let newDate = Calendar.current.date(byAdding: .day, value: 1, to: date) ?? Date()
        let timePeriodProvider = TimePeriodProvider()
        let expected = timePeriodProvider.stringValue(from: newDate)
        sut.toTextSet = verify(expectation: expectation, expected: expected)

        // when
        sut.setToDate(newDate)

        // then
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testCurrencyDetailViewModelCallsToDateSetWhenSetToDate() {
        // given
        let expectation = XCTestExpectation()
        let newDate = Calendar.current.date(byAdding: .day, value: 1, to: date) ?? Date()
        sut.toDateSet = verify(expectation: expectation, expected: [date, newDate], count: 2)

        // when
        sut.setToDate(newDate)

        // then
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testCurrencyDetailViewModelCallsStartAnimatingWhenSubmit() {
        // given
        let expectation = XCTestExpectation()
        sut.startAnimating = verify(expectation: expectation)

        // when
        sut.submit()

        // then
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testCurrencyDetailViewModelCallsDateLoadedWhenSubmit() {
        // given
        let expectation = XCTestExpectation()
        let expected = CurrencyCellData.cellData(from: CurrencyDetailList.fixture)
        sut.dataLoaded = verify(expectation: expectation, expected: [[], expected], count: 2)

        // when
        sut.submit()

        // then
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testCurrencyDetailViewModelCallsReloadDataWhenSubmit() {
        // given
        let expectation = XCTestExpectation()
        sut.reloadData = verify(expectation: expectation)

        // when
        sut.submit()

        // then
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testCurrencyDetailViewModelCallsStopAnimatingWhenSubmit() {
        // given
        let expectation = XCTestExpectation()
        sut.stopAnimating = verify(expectation: expectation)

        // when
        sut.submit()

        // then
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testCurrencyDetailViewModelCallsStartAnimatingWhenRefreshData() {
        // given
        let expectation = XCTestExpectation()
        sut.startAnimating = verify(expectation: expectation)

        // when
        sut.refreshData()

        // then
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testCurrencyDetailViewModelCallsDateLoadedWhenRefreshData() {
        // given
        let expectation = XCTestExpectation()
        let expected = CurrencyCellData.cellData(from: CurrencyDetailList.fixture)
        sut.dataLoaded = verify(expectation: expectation, expected: [[], expected], count: 2)

        // when
        sut.refreshData()

        // then
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testCurrencyDetailViewModelCallsReloadDataWhenRefreshData() {
        // given
        let expectation = XCTestExpectation()
        sut.reloadData = verify(expectation: expectation)

        // when
        sut.refreshData()

        // then
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testCurrencyDetailViewModelCallsStopAnimatingWhenRefreshData() {
        // given
        let expectation = XCTestExpectation()
        sut.stopAnimating = verify(expectation: expectation)

        // when
        sut.refreshData()

        // then
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testCurrencyDetailViewModelCallsTitleWhenConnected() {
        // given
        let expectation = XCTestExpectation()

        // when
        sut.title = verify(expectation: expectation, expected: Currency.fixtureMidValue.name)

        // then
        wait(for: [expectation], timeout: 0.01)
    }
}
