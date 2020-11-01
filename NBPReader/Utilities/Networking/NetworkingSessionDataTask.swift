import Foundation

protocol NetworkingSessionDataTask {
    func resume()
}

extension URLSessionDataTask: NetworkingSessionDataTask { }
