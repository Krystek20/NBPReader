import Foundation

struct CurrencyDetail: Decodable, Equatable {

    // MARK: - Properties

    let effectiveDate: String
    let value: CurrencyValue

    // MARK: - CodingKeys

    private enum CodingKeys: String, CodingKey {
        case effectiveDate
    }

    // MARK: - Initialization

    init(effectiveDate: String, value: CurrencyValue) {
        self.effectiveDate = effectiveDate
        self.value = value
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let effectiveDate = try container.decode(String.self, forKey: .effectiveDate)
        let singleContainer = try decoder.singleValueContainer()
        let value = try singleContainer.decode(CurrencyValue.self)
        self.init(effectiveDate: effectiveDate, value: value)
    }
}
