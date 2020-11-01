import Foundation
@testable import NBPReader

enum JsonData {

    private static let decodableObject = [
        "status": 1,
    ]

    static var decodableData: Data? {
        try? JSONSerialization.data(withJSONObject: decodableObject, options: .prettyPrinted)
    }

    private static let currencyList: [String: Any] = [
        "table": CurrencyList.fixture.table,
        "effectiveDate": CurrencyList.fixture.effectiveDate,
        "rates": [
            currency
        ]
    ]

    static func currencyListData() throws -> Data {
        try JSONSerialization.data(withJSONObject: currencyList, options: .prettyPrinted)
    }

    private static let currency: [String: Any] = [
        "currency": Currency.fixtureMidValue.name,
        "code": Currency.fixtureMidValue.code,
        "mid": 0.1270
    ]

    static func currencyData() throws -> Data {
        try JSONSerialization.data(withJSONObject: currency, options: .prettyPrinted)
    }
    
    private static let currencyMarketValue: [String: Any] = [
        "bid": 0.1,
        "ask": 0.2
    ]

    static func currencyMarketValueData() throws -> Data {
        try JSONSerialization.data(withJSONObject: currencyMarketValue, options: .prettyPrinted)
    }

    private static let currencyDetail: [String: Any] = [
        "effectiveDate": CurrencyDetail.fixture.effectiveDate,
        "mid": 0.5104
    ]

    static func currencyDetailData() throws -> Data {
        try JSONSerialization.data(withJSONObject: currencyDetail, options: .prettyPrinted)
    }

    private static let currencyDetailList: [String: Any] = [
        "rates": [currencyDetail],
    ]

    static func currencyDetailListData() throws -> Data {
        try JSONSerialization.data(withJSONObject: currencyDetailList, options: .prettyPrinted)
    }
}
