import Foundation
@testable import NBPReader

final class CurrencyListProviderStub: CurrencyProviding {

    var error: Error?

    func fetchDetails(configuration: CurrencyProvider.Configuration, _ completion: @escaping (Result<CurrencyDetailList, Error>) -> Void) {
        if let error = error {
            completion(.failure(error))
        } else {
            completion(.success(.fixture))
        }
    }

    func fetchCurrencies(tableName name: String, completion: (Result<[CurrencyList], Error>) -> Void) {
        if let error = error {
            completion(.failure(error))
        } else {
            completion(.success([.fixture]))
        }
    }
}
