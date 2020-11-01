import Foundation
@testable import NBPReader

final class CurrencyListProviderStub: CurrencyProviding {

    var error: Error?

    func fetchDetails(configuration: CurrencyProvider.Configuration, _ completion: @escaping (Result<CurrencyListWrapper<CurrencyDetailList>, Error>) -> Void) {
        if let error = error {
            completion(.failure(error))
        } else {
            completion(.success(CurrencyListWrapper(object: .fixture)))
        }
    }

    func fetchCurrencies(tableName name: String, completion: (Result<CurrencyListWrapper<CurrencyList>, Error>) -> Void) {
        if let error = error {
            completion(.failure(error))
        } else {
            completion(.success(CurrencyListWrapper(object: .fixture)))
        }
    }
}
