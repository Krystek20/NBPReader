import Foundation

protocol NetworkingType {
    func request<T: Decodable>(with: Endpoint, _: @escaping (Result<T, Error>) -> Void)
}

enum NetworkingError: Error, Equatable {
    case emptyData
    case emptyList
    case badUrl
}

final class Networking: NetworkingType {

    // MARK: - Properties

    private let session: NetworkingSession
    private let decoder: JSONDecoder

    // MARK: - Initialization

    init(session: NetworkingSession = URLSession(configuration: .default),
         decoder: JSONDecoder = JSONDecoder()) {
        self.session = session
        self.decoder = decoder
    }

    func request<T: Decodable>(with endpoint: Endpoint, _ completion: @escaping (Result<T, Error>) -> Void) {
        guard let url = endpoint.url else { completion(.failure(NetworkingError.badUrl)); return }
        let dataTask = session.networkingDataTask(with: url, completionHandler: { [weak self] data, response, error in
            self?.handleRequest(data: data, response: response, error: error, completion)
        })
        dataTask.resume()
    }

    // MARK: - Managing

    private func handleRequest<T: Decodable>(data: Data?, response: URLResponse?, error: Error?, _ completion: @escaping (Result<T, Error>) -> Void) {
        if let error = error { handleResult(.failure(error), completion); return }
        guard !isEmptyList(response: response) else { handleResult(.failure(NetworkingError.emptyList), completion); return }
        guard let data = data else { handleResult(.failure(NetworkingError.emptyData), completion); return }
        do {
            let object = try decoder.decode(T.self, from: data)
            handleResult(.success(object), completion)
        } catch {
            handleResult(.failure(error), completion)
        }
    }

    private func handleResult<T: Decodable>(_ result: Result<T, Error>, _ completion: @escaping (Result<T, Error>) -> Void) {
        DispatchQueue.main.async {
            completion(result)
        }
    }

    private func isEmptyList(response: URLResponse?) -> Bool {
        (response as? HTTPURLResponse)?.statusCode == 404
    }
}
