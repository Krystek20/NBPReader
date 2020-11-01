import XCTest
@testable import NBPReader

final class CurrencyTests: XCTestCase {

    private let decoder = JSONDecoder()

    func testCurrencyDecodable() throws {
        // given
        let data = try JsonData.currencyData()

        // when
        let currency = try decoder.decode(Currency.self, from: data)

        // then
        XCTAssertEqual(currency, Currency.fixtureMidValue)
    }
}
