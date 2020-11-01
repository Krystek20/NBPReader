import Foundation

protocol CurrencyFormatting {
    func string(from: Double) -> String
}

final class CurrencyFormatter: CurrencyFormatting {
    func string(from value: Double) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumIntegerDigits = 6
        formatter.maximumFractionDigits = 6
        return formatter.string(for: value) ?? .empty
    }
}
