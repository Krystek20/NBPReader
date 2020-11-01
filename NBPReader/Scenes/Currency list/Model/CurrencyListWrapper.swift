import Foundation

struct CurrencyListWrapper<T: Decodable>: Decodable {

    // MARK: - Properties

    let object: T

    // MARK: - Initialization

    init(object: T) {
        self.object = object
    }

    init(from decoder: Decoder) throws {
        let object: T
        let container = try decoder.singleValueContainer()
        if let objects = try? container.decode([T].self),
           let firstObject = objects.first {
            object = firstObject
        } else {
            object = try container.decode(T.self)
        }
        self.init(object: object)
    }
}
