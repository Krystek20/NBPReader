import Foundation
@testable import NBPReader

extension Currency {
    static let fixtureMidValue = Currency(name: "bat (Tajlandia)", code: "THB", value: .mid(value: 0.1270))
    static let fixtureMarketValue = Currency(name: "bat (Tajlandia)", code: "THB", value: .market(bid: 0.1, ask: 0.2))
}
