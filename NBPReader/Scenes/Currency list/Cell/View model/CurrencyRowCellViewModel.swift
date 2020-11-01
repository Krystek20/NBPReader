import Foundation

protocol CurrencyRowCellViewModelType: class {
    var effectiveDateSet: PropertyOutput<String>? { get set }
    var nameSet: PropertyOutput<String>? { get set }
    var valueSet: PropertyOutput<String>? { get set }
    var isNameLabelHidden: PropertyOutput<Bool>? { get set }
}

final class CurrencyRowCellViewModel: CurrencyRowCellViewModelType {

    // MARK: - Properties

    private let data: CurrencyCellData
    private let currencyFormatter: CurrencyFormatting

    // MARK: - Initialization

    init(data: CurrencyCellData, currencyFormatter: CurrencyFormatting = CurrencyFormatter()) {
        self.data = data
        self.currencyFormatter = currencyFormatter
    }

    // MARK: - Outputs

    var effectiveDateSet: PropertyOutput<String>? {
        didSet { effectiveDateSet?(data.effectiveDate) }
    }
    var nameSet: PropertyOutput<String>? {
        didSet { configureTitle() }
    }
    var valueSet: PropertyOutput<String>? {
        didSet { valueSet?(prepareValue()) }
    }
    var isNameLabelHidden: PropertyOutput<Bool>?

    // MARK: - Managing

    private func configureTitle() {
        if let displayName = data.displayName {
            nameSet?(displayName)
        } else {
            isNameLabelHidden?(true)
        }
    }

    private func prepareValue() -> String {
        switch data.value {
        case .mid(let value):
            return "Mid: " + currencyFormatter.string(from: value)
        case .market(let bid, let ask):
            return "Ask: " + currencyFormatter.string(from: ask) + .space + .minus + " Bid: " + currencyFormatter.string(from: bid)
        }
    }
}
