import XCTest
@testable import NBPReader

final class TimePeriodProviderTests: XCTestCase {

    func testTimePeriodProviderReturnDataString() throws {
        // given
        let sut = TimePeriodProvider()
        let date = try XCTUnwrap(prepareDate())

        // when
        let result = sut.stringValue(from: date)

        // then
        XCTAssertEqual(result, "2020-02-01")
    }

    private func prepareDate() -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd HH:mm"
        return formatter.date(from: "2020/02/01 00:31")
    }
}
