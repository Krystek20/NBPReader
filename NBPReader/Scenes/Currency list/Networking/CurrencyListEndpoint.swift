import Foundation

enum CurrencyListEndpoint: Endpoint {
    case list(tableName: String)
    case timeInterval(configuration: CurrencyProvider.Configuration)

    var url: URL? {
        var components = baseURLComponents
        components.path = path
        components.queryItems = queryItems
        return components.url
    }

    private var path: String {
        switch self {
        case .list(let tableName):
            return "/api/exchangerates/tables/\(tableName)"
        case .timeInterval(let configuration):
            return "/api/exchangerates/rates/\(configuration.tableName)/\(configuration.code)/\(configuration.fromDate)/\(configuration.toDate)"
        }
    }

    private var queryItems: [URLQueryItem] {
        [URLQueryItem(name: "format", value: "json")]
    }
}
