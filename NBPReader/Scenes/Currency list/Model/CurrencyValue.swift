import Foundation

enum CurrencyValue: Decodable, Equatable {
    case mid(value: Double)
    case market(bid: Double, ask: Double)

    // MARK: - CodingKeys

    private enum CodingKeys: String, CodingKey {
        case mid
        case bid
        case ask
    }

    // MARK: - Initialization

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        if let mid = try container.decodeIfPresent(Double.self, forKey: .mid) {
            self = .mid(value: mid)
        } else {
            let ask = try container.decode(Double.self, forKey: .ask)
            let bid = try container.decode(Double.self, forKey: .bid)
            self = .market(bid: bid, ask: ask)
        }
    }
}
