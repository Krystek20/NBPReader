import Foundation
@testable import NBPReader

final class NetworkingSessionDataTaskMock: NetworkingSessionDataTask {

    // MARK: Properties

    private(set) var resumeCalled = Int.zero

    // MARK: - Managing

     func resume() {
        resumeCalled += 1
    }
}
