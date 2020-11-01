import XCTest
@testable import NBPReader

final class CurrencyValueTests: XCTestCase {

    private let decoder = JSONDecoder()

    func testCurrencyMarketValueDecodable() throws {
        // given
        let data = try JsonData.currencyMarketValueData()

        // when
        let currencyValue = try decoder.decode(CurrencyValue.self, from: data)

        // then
        XCTAssertEqual(currencyValue, Currency.fixtureMarketValue.value)
    }

    func testCurrencyMidValueDecodable() throws {
        // given
        let data = try JsonData.currencyData()

        // when
        let currencyValue = try decoder.decode(CurrencyValue.self, from: data)

        // then
        XCTAssertEqual(currencyValue, Currency.fixtureMidValue.value)
    }
}
