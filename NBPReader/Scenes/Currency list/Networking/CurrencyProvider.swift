import Foundation

protocol CurrencyProviding {
    func fetchCurrencies(tableName: String, completion: @escaping (Result<[CurrencyList], Error>) -> Void)
    func fetchDetails(configuration: CurrencyProvider.Configuration, _: @escaping (Result<CurrencyDetailList, Error>) -> Void)
}

final class CurrencyProvider: CurrencyProviding {

    // MARK: - Properties

    private let networking: NetworkingType

    // MARK: - Initialization

    init(networking: NetworkingType = Networking()) {
        self.networking = networking
    }

    // MARK: - Providing

    func fetchCurrencies(tableName: String, completion: @escaping (Result<[CurrencyList], Error>) -> Void) {
        networking.request(with: CurrencyListEndpoint.list(tableName: tableName), completion)
    }

    func fetchDetails(configuration: CurrencyProvider.Configuration, _ completion: @escaping (Result<CurrencyDetailList, Error>) -> Void) {
        networking.request(with: CurrencyListEndpoint.timeInterval(configuration: configuration), completion)
    }
}
