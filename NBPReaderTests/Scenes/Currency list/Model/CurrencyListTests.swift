import XCTest
@testable import NBPReader

final class CurrencyListTests: XCTestCase {

    private let decoder = JSONDecoder()

    func testCurrencyListDecodable() throws {
        // given
        let data = try JsonData.currencyListData()

        // when
        let currencyList = try decoder.decode(CurrencyList.self, from: data)

        // then
        XCTAssertEqual(currencyList, CurrencyList.fixture)
    }
}
