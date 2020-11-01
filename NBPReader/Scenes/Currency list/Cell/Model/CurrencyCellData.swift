import Foundation

struct CurrencyCellData: Equatable {
    let value: CurrencyValue
    let effectiveDate: String
    let displayName: String?

    static func cellData(from currencyList: CurrencyList) -> [CurrencyCellData] {
        currencyList.rates.map { CurrencyCellData(value: $0.value, effectiveDate: currencyList.effectiveDate, displayName: $0.displayName) }
    }

    static func cellData(from detailsList: CurrencyDetailList) -> [CurrencyCellData] {
        detailsList.rates.map { CurrencyCellData(value: $0.value, effectiveDate: $0.effectiveDate, displayName: nil) }
    }
}
