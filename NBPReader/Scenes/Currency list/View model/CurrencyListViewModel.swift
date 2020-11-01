import Foundation

protocol CurrencyListViewModelType: class {
    var startAnimating: Output? { get set }
    var stopAnimating: Output? { get set }
    var dataLoaded: PropertyOutput<[CurrencyCellData]>? { get set }
    var reloadData: Output? { get set }
    var segmentItemPrepared: PropertyOutput<[String]>? { get set }
    var segmentIndexSelected: PropertyOutput<Int>? { get set }
    var currencySelected: PropertyOutput<CurrencySelected>? { get set }
    var title: PropertyOutput<String>? { get set }
    var errorHandled: PropertyOutput<Error>? { get set }
    func viewDidLoad()
    func changeTable(with: Int)
    func refreshData()
    func select(index: Int)
}

final class CurrencyListViewModel: CurrencyListViewModelType {

    // MARK: - Properties

    private let currencyProviding: CurrencyProviding
    private var selectedTable = Configuration.tableNames.first ?? .empty
    private var fetchedObject: CurrencyList? {
        didSet { loadFetchedObject() }
    }

    // MARK: - Configuration

    private enum Configuration {
        static let title = "Currency List"
        static let tableNames = ["A", "B", "C"]
        static var tableNameTitles: [String] { tableNames.map { "Table " + $0 } }
    }

    // MARK: - Initialization

    init(currencyProviding: CurrencyProviding = CurrencyProvider()) {
        self.currencyProviding = currencyProviding
    }

    // MARK: - Inputs

    func viewDidLoad() {
        loadCurrencyList()
    }

    func changeTable(with index: Int) {
        guard Configuration.tableNames.indices.contains(index) else { return }
        selectedTable = Configuration.tableNames[index]
        reloadTable()
    }

    func refreshData() {
        reloadTable()
    }

    func select(index: Int) {
        guard let rates = fetchedObject?.rates, rates.indices.contains(index) else { return }
        let selected = CurrencySelected(currency: rates[index], tableName: selectedTable)
        currencySelected?(selected)
    }

    // MARK: - Outputs

    var startAnimating: Output? {
        didSet { startAnimating?() }
    }
    var stopAnimating: Output?
    var dataLoaded: PropertyOutput<[CurrencyCellData]>?
    var reloadData: Output?
    var segmentItemPrepared: PropertyOutput<[String]>? {
        didSet {
            segmentItemPrepared?(Configuration.tableNameTitles)
            segmentIndexSelected?(.zero)
        }
    }
    var segmentIndexSelected: PropertyOutput<Int>?
    var currencySelected: PropertyOutput<CurrencySelected>?
    var title: PropertyOutput<String>? {
        didSet { title?(Configuration.title) }
    }
    var errorHandled: PropertyOutput<Error>?

    // MARK: - Managing

    private func loadFetchedObject() {
        guard let currencyList = fetchedObject else { removeData(); return }
        let data = CurrencyCellData.cellData(from: currencyList)
        setupData(data)
    }

    private func removeData() {
        setupData([])
    }

    private func setupData(_ data: [CurrencyCellData]) {
        dataLoaded?(data)
        reloadData?()
    }

    private func reloadTable() {
        startAnimating?()
        fetchedObject = nil
        loadCurrencyList()
    }

    private func loadCurrencyList() {
        currencyProviding.fetchCurrencies(tableName: selectedTable) { [weak self] result in
            self?.handleFetchedCurrencyList(with: result)
        }
    }

    private func handleFetchedCurrencyList(with result: Result<CurrencyListWrapper<CurrencyList>, Error>) {
        switch result {
        case .success(let wrapper):
            prepareCurrencyListViewData(from: wrapper.object)
        case .failure(let error):
            handleError(error)
        }
    }

    private func prepareCurrencyListViewData(from currencyList: CurrencyList) {
        stopAnimating?()
        fetchedObject = currencyList
    }

    private func handleError(_ error: Error) {
        stopAnimating?()
        fetchedObject = nil
        errorHandled?(error)
    }
}
