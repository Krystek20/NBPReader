import Foundation
@testable import NBPReader

final class NetworkingSessionMock: NetworkingSession {

    // MARK: - Properties

    private(set) var networkingTaskCount = Int.zero
    private let networkingSessionDataTask: NetworkingSessionDataTask
    private var completionHandler: ((Data?, URLResponse?, Error?) -> Void)?

    // MARK: - Initialization

    init(networkingSessionDataTask: NetworkingSessionDataTask) {
        self.networkingSessionDataTask = networkingSessionDataTask
    }

    func networkingDataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> NetworkingSessionDataTask {
        networkingTaskCount += 1
        self.completionHandler = completionHandler
        return networkingSessionDataTask
    }

    func resumeDataTask(with data: Data?) {
        completionHandler?(data, nil, nil)
    }

    func resumeError(with error: Error?) {
        completionHandler?(nil, nil, error)
    }

    func resumeResponse(with response: HTTPURLResponse?) {
        completionHandler?(nil, response, nil)
    }
}
