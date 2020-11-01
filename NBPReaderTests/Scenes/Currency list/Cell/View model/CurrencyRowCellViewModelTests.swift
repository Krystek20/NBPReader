import XCTest
@testable import NBPReader

final class CurrencyRowCellViewModelTests: XCTestCase {

    private var sut: CurrencyRowCellViewModelType!

    override func setUp() {
        super.setUp()
        let data = CurrencyCellData(value: Currency.fixtureMidValue.value, effectiveDate: CurrencyList.fixture.effectiveDate, displayName: Currency.fixtureMidValue.displayName)
        sut = CurrencyRowCellViewModel(data: data)
    }

    override func tearDown() {
        super.tearDown()
        sut = nil
    }

    func testCurrencyRowCellViewModelCallEffectiveDateSetWhenConnected() {
        // given
        let expectation = XCTestExpectation()

        // when
        sut.effectiveDateSet = verify(expectation: expectation, expected: CurrencyList.fixture.effectiveDate)

        // then
        wait(for: [expectation], timeout: 0.01)
    }

    func testCurrencyRowCellViewModelCallNameSetWhenConnected() {
        // given
        let expectation = XCTestExpectation()
        let expectedName = "\(Currency.fixtureMidValue.code) - \(Currency.fixtureMidValue.name)"
        
        // when
        sut.nameSet = verify(expectation: expectation, expected: expectedName)

        // then
        wait(for: [expectation], timeout: 0.01)
    }

    func testCurrencyRowCellViewModelCallNotNameSetWhenConnectedNameSetWithDisplayNameNil() {
        // given
        let data = CurrencyCellData(
            value: Currency.fixtureMidValue.value,
            effectiveDate: CurrencyList.fixture.effectiveDate,
            displayName: nil
        )
        sut = CurrencyRowCellViewModel(data: data)
        let expectation = XCTestExpectation()

        // when
        sut.nameSet = verifyNotCall(expectation: expectation)

        // then
        wait(for: [expectation], timeout: 0.01)
    }

    func testCurrencyRowCellViewModelCallIsNameLabelHiddenWhenConnectedNameSetWithDisplayNameNil() {
        // given
        let data = CurrencyCellData(
            value: Currency.fixtureMidValue.value,
            effectiveDate: CurrencyList.fixture.effectiveDate,
            displayName: nil
        )
        sut = CurrencyRowCellViewModel(data: data)
        let expectation = XCTestExpectation()
        sut.isNameLabelHidden = verify(expectation: expectation, expected: true)

        // when
        sut.nameSet = { _ in }

        // then
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testCurrencyRowCellViewModelCallValueSetSetWhenConnectedWithMidValue() {
        // given
        let expectation = XCTestExpectation()
        let expectedValue = prepareExpectedName(from: Currency.fixtureMidValue.value)

        // when
        sut.valueSet = verify(expectation: expectation, expected: expectedValue)

        // then
        wait(for: [expectation], timeout: 0.01)
    }

    func testCurrencyRowCellViewModelCallValueSetSetWhenConnectedWithAskBidValues() {
        // given
        let data = CurrencyCellData(
            value: Currency.fixtureMarketValue.value,
            effectiveDate: CurrencyList.fixture.effectiveDate,
            displayName: nil
        )
        sut = CurrencyRowCellViewModel(data: data)
        let expectation = XCTestExpectation()
        let expectedValue = prepareExpectedName(from: Currency.fixtureMarketValue.value)

        // when
        sut.valueSet = verify(expectation: expectation, expected: expectedValue)

        // then
        wait(for: [expectation], timeout: 0.01)
    }

    private func prepareExpectedName(from value: CurrencyValue) -> String {
        switch value {
        case .mid(let value):
            return "Mid: \(value)"
        case .market(let bid, let ask):
            return "Ask: " + "\(ask)" + .space + .minus + " Bid: \(bid)"
        }
    }
}
