import Foundation

struct Currency: Decodable, Equatable {

    // MARK: - Properties

    let name: String
    let code: String
    let value: CurrencyValue

    // MARK: - CodingKeys

    private enum CodingKeys: String, CodingKey {
        case currency
        case code
    }

    // MARK: - Initialization

    init(name: String, code: String, value: CurrencyValue) {
        self.name = name
        self.code = code
        self.value = value
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let name = try container.decode(String.self, forKey: .currency)
        let code = try container.decode(String.self, forKey: .code)
        let singleContainer = try decoder.singleValueContainer()
        let value = try singleContainer.decode(CurrencyValue.self)
        self.init(name: name, code: code, value: value)
    }
}

extension Currency {
    var displayName: String {
        code + .space + .minus + .space + name
    }
}
