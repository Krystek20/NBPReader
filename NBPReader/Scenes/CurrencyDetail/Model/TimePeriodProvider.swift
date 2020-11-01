import Foundation

protocol TimePeriodProviding {
    func stringValue(from: Date) -> String
}

final class TimePeriodProvider: TimePeriodProviding {

    // MARK: - Properties

    private let dateFormatter: DateFormatter

    // MARK: - Initialization

    init(dateFormatter: DateFormatter = DateFormatter(format: "yyyy-MM-dd")) {
        self.dateFormatter = dateFormatter
    }

    // MARK: - Managing

    func stringValue(from date: Date) -> String {
        dateFormatter.string(from: date)
    }
}
