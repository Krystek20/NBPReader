import Foundation
@testable import NBPReader

extension CurrencyList {
    static let fixture = CurrencyList(table: "A", effectiveDate: "2020-10-30", rates: [Currency.fixtureMidValue])
}
