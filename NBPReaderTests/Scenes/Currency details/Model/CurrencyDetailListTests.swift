import XCTest
@testable import NBPReader

final class CurrencyDetailListTests: XCTestCase {

    private let decoder = JSONDecoder()

    func testCurrencyDetailListDecodable() throws {
        // given
        let data = try JsonData.currencyDetailListData()

        // when
        let currencyDetailList = try decoder.decode(CurrencyDetailList.self, from: data)

        // then
        XCTAssertEqual(currencyDetailList, CurrencyDetailList.fixture)
    }
}
