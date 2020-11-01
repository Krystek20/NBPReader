import Foundation

protocol CurrencyDetailViewModelType: class {

    // MARK: - Inputs

    func viewDidLoad()
    func setFromDate(_: Date)
    func setToDate(_: Date)
    func submit()
    func refreshData()

    // MARK: - Outputs

    var startAnimating: Output? { get set }
    var stopAnimating: Output? { get set }
    var fromDateSet: PropertyOutput<Date>? { get set }
    var toDateSet: PropertyOutput<Date>? { get set }
    var fromTextSet: PropertyOutput<String>? { get set }
    var toTextSet: PropertyOutput<String>? { get set }
    var dataLoaded: PropertyOutput<[CurrencyCellData]>? { get set }
    var closed: Output? { get set }
    var reloadData: Output? { get set }
    var title: PropertyOutput<String>? { get set }
    var errorHandled: PropertyOutput<Error>? { get set }
}

final class CurrencyDetailViewModel: CurrencyDetailViewModelType {

    // MARK: - Properties

    private let currencySelected: CurrencySelected
    private let currencyProviding: CurrencyProviding
    private let timePeriodProvider: TimePeriodProviding
    private let dateProvider: DateProviding

    // MARK: - Initialization

    init(currencySelected: CurrencySelected,
         currencyProviding: CurrencyProviding = CurrencyProvider(),
         timePeriodProvider: TimePeriodProviding = TimePeriodProvider(),
         dateProvider: DateProviding = DateProvider()) {
        self.currencyProviding = currencyProviding
        self.timePeriodProvider = timePeriodProvider
        self.currencySelected = currencySelected
        self.dateProvider = dateProvider
        setupDateProviderBindings()
    }

    // MARK: - Setup

    deinit {
        closed?()
    }

    private func setupDateProviderBindings() {

        dateProvider.fromDateSet = { [weak self] date in
            self?.setupFromText(date: date)
            self?.fromDateSet?(date)
        }

        dateProvider.toDateSet = { [weak self] date in
            self?.setupToText(date: date)
            self?.toDateSet?(date)
        }
    }

    // MARK: - Inputs

    func viewDidLoad() {
        dateProvider.loadDates()
        loadCurrencyDetails()
    }

    func submit() {
        reloadCurrencyDetails()
    }

    func refreshData() {
        reloadCurrencyDetails()
    }

    func setFromDate(_ date: Date) {
        dateProvider.setFromDate(date)
    }

    func setToDate(_ date: Date) {
        dateProvider.setToDate(date)
    }

    // MARK: - Outputs

    var closed: Output?
    var startAnimating: Output? {
        didSet { startAnimating?() }
    }
    var stopAnimating: Output?
    var fromDateSet: PropertyOutput<Date>? {
        didSet { fromDateSet?(dateProvider.fromDate) }
    }
    var toDateSet: PropertyOutput<Date>? {
        didSet { toDateSet?(dateProvider.toDate) }
    }
    var dataLoaded: PropertyOutput<[CurrencyCellData]>?
    var reloadData: Output?
    var fromTextSet: PropertyOutput<String>?
    var toTextSet: PropertyOutput<String>?
    var title: PropertyOutput<String>? {
        didSet { title?(currencySelected.currency.name) }
    }
    var errorHandled: PropertyOutput<Error>?

    // MARK: - Managing

    private func setupFromText(date: Date) {
        fromTextSet?(timePeriodProvider.stringValue(from: date))
    }

    private func setupToText(date: Date) {
        toTextSet?(timePeriodProvider.stringValue(from: date))
    }

    private func reloadCurrencyDetails() {
        startAnimating?()
        dataLoaded?([])
        loadCurrencyDetails()
    }

    private func loadCurrencyDetails() {
        let configuration = CurrencyProvider.Configuration(
            tableName: currencySelected.tableName,
            fromDate: timePeriodProvider.stringValue(from: dateProvider.fromDate),
            toDate: timePeriodProvider.stringValue(from: dateProvider.toDate),
            code: currencySelected.currency.code
        )
        currencyProviding.fetchDetails(configuration: configuration) { [weak self] result in
            self?.handleFetchedCurrencyList(with: result)
        }
    }

    private func handleFetchedCurrencyList(with result: Result<CurrencyListWrapper<CurrencyDetailList>, Error>) {
        switch result {
        case .success(let wrapper):
            prepareCurrencyListViewData(from: wrapper.object)
        case .failure(let error):
            handleError(error)
        }
    }

    private func prepareCurrencyListViewData(from currencyDetailList: CurrencyDetailList) {
        stopLoading(with: CurrencyCellData.cellData(from: currencyDetailList))
    }

    private func handleError(_ error: Error) {
        stopLoading(with: [])
        guard error as? NetworkingError != NetworkingError.emptyList else { return }
        errorHandled?(error)
    }

    private func stopLoading(with data: [CurrencyCellData]) {
        stopAnimating?()
        dataLoaded?(data)
        reloadData?()
    }
}
