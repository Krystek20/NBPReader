import Foundation

protocol Endpoint {
    var url: URL? { get }
}

extension Endpoint {
    var baseURLComponents: URLComponents {
        var urlComponents = URLComponents()
        urlComponents.scheme = "http"
        urlComponents.host = "api.nbp.pl"
        return urlComponents
    }
}
