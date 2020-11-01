import Foundation

protocol DateProviding: class {
    var fromDate: Date { get }
    var toDate: Date { get}
    func setFromDate(_: Date)
    func setToDate(_: Date)
    func loadDates()
    var fromDateSet: PropertyOutput<Date>? { get set }
    var toDateSet: PropertyOutput<Date>? { get set }
}

final class DateProvider: DateProviding {

    // MARK Properties

    var fromDate: Date
    var toDate: Date

    // MARK: - Initialization

    init(initialDate: Date = Date()) {
        toDate = initialDate
        fromDate = Calendar.current.date(byAdding: .day, value: -1, to: initialDate) ?? initialDate
    }

    // MARK: - Inputs

    func loadDates() {
        fromDateSet?(fromDate)
        toDateSet?(toDate)
    }

    func setFromDate(_ date: Date) {
        fromDate = date
        verifyDates()
    }

    func setToDate(_ date: Date) {
        toDate = date
        verifyDates()
        toDateSet?(toDate)
    }

    // MARK: - Outputs

    var fromDateSet: PropertyOutput<Date>?
    var toDateSet: PropertyOutput<Date>?

    // MARK: - Managing

    private func verifyDates() {
        if toDate < fromDate {
            fromDate = Calendar.current.date(byAdding: .day, value: -1, to: toDate) ?? toDate
        }
        let oneYearLeft = Calendar.current.date(byAdding: .year, value: -1, to: toDate) ?? toDate
        if fromDate < oneYearLeft {
            fromDate = oneYearLeft
        }
        fromDateSet?(fromDate)
    }
}
