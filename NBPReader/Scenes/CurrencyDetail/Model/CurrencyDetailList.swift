import Foundation

struct CurrencyDetailList: Decodable, Equatable {
    let rates: [CurrencyDetail]
}
