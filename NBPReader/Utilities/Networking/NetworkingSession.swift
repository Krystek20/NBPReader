import Foundation

protocol NetworkingSession {
    func networkingDataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> NetworkingSessionDataTask
}

extension URLSession: NetworkingSession {
    func networkingDataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> NetworkingSessionDataTask {
        dataTask(with: url, completionHandler: completionHandler)
    }
}
