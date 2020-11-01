import XCTest
@testable import NBPReader

final class CurrencyListProviderTests: XCTestCase {

    private var mock: NetworkingMock<[CurrencyList]>!
    private var sut: CurrencyProvider!
    
    override func setUp() {
        super.setUp()
        mock = NetworkingMock<[CurrencyList]>()
        sut = CurrencyProvider(networking: mock)
        
    }
    
    override func tearDown() {
        super.tearDown()
        mock = nil
        sut = nil
    }
    
    func testCurrencyListProviderCallsCompletionOneTimeWhenFetchCurrencyList() {
        // when
        sut.fetchCurrencies(tableName: "A", completion: { _ in })

        // then
        XCTAssertEqual(mock.requestedCount, 1)
    }

    func testCurrencyListProviderShouldCallFetchCurrencyListEndpoint() {
        // when
        sut.fetchCurrencies(tableName: "A", completion: { _ in })

        // then
        XCTAssertEqual(mock.endpoint?.url?.absoluteString, "http://api.nbp.pl/api/exchangerates/tables/A?format=json")
    }
    
    func testCurrencyListProviderShouldCallFetchTimeIntervalEndpoint() {
        let configuration = CurrencyProvider.Configuration(tableName: "B", fromDate: "2020-05-22", toDate: "2020-05-23", code: "USD")

        // when
        sut.fetchDetails(configuration: configuration, { _ in })
        // then
        XCTAssertEqual(mock.endpoint?.url?.absoluteString, "http://api.nbp.pl/api/exchangerates/rates/B/USD/2020-05-22/2020-05-23?format=json")
    }
}
