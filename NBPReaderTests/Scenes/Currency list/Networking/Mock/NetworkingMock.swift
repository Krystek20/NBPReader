import Foundation
@testable import NBPReader

final class NetworkingMock<T: Decodable>: NetworkingType {

    // MARK: - Properties

    private(set) var requestedCount = Int.zero
    private(set) var endpoint: Endpoint?

    // MARK: - Mocking

    func request<T>(with endpoint: Endpoint, _ completion: @escaping (Result<T, Error>) -> Void) where T: Decodable {
        self.endpoint = endpoint
        requestedCount += 1
    }
}
