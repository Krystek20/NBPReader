import XCTest
@testable import NBPReader

final class CurrencyDetailTests: XCTestCase {

    private let decoder = JSONDecoder()

    func testCurrencyDetailDecodable() throws {
        // given
        let data = try JsonData.currencyDetailData()

        // when
        let currencyDetail = try decoder.decode(CurrencyDetail.self, from: data)

        // then
        XCTAssertEqual(currencyDetail, CurrencyDetail.fixture)
    }
}
