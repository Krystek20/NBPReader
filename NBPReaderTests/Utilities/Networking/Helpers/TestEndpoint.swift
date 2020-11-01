import Foundation
@testable import NBPReader

enum TestEndpoint: Endpoint {
    case correct
    case fail

    var url: URL? {
        switch self {
        case .correct:
            return URL(string: "www.foo.com")
        case .fail:
            return nil
        }
    }
}
