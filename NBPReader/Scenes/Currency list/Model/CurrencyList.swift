import Foundation

struct CurrencyList: Decodable, Equatable {
    let table: String
    let effectiveDate: String
    let rates: [Currency]
}
