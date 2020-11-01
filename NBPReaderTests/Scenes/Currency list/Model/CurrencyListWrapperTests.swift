import XCTest
@testable import NBPReader

final class CurrencyListWrapperTests: XCTestCase {

    private let decoder = JSONDecoder()

    func testCurrencyListWrapperInitWithArray() throws {
        // given
        let array = [["status": 1]]
        let data = try JSONSerialization.data(withJSONObject: array, options: .prettyPrinted)

        // when
        let wrapped = try decoder.decode(CurrencyListWrapper<DecodableData>.self, from: data)

        // then
        XCTAssertEqual(wrapped.object, DecodableData(status: 1))
    }

    func testCurrencyListWrapperInitWithDictionary() throws {
        // given
        let array = ["status": 1]
        let data = try JSONSerialization.data(withJSONObject: array, options: .prettyPrinted)

        // when
        let wrapped = try decoder.decode(CurrencyListWrapper<DecodableData>.self, from: data)

        // then
        XCTAssertEqual(wrapped.object, DecodableData(status: 1))
    }
}
