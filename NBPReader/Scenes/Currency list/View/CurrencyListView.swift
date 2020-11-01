import UIKit

final class CurrencyListView: UIView {

    // MARK: - Views

    private let segmentControl = Subviews.segmentControl
    private let tableView = Subviews.tableView
    private let loaderView = Subviews.loaderView

    // MARK: - Properties

    var viewModel: CurrencyListViewModelType? {
        didSet { setupBindings() }
    }
    private let dataSource: CurrencyListViewDataSource
    private let delegate: CurrencyListViewDelegate

    // MARK: - Initialization

    init(dataSource: CurrencyListViewDataSource = CurrencyListViewDataSource(),
         delegate: CurrencyListViewDelegate = CurrencyListViewDelegate()) {
        self.dataSource = dataSource
        self.delegate = delegate
        super.init(frame: .zero)
        setupSelf()
        setupLayout()
    }

    required init?(coder: NSCoder) {
        return nil
    }

    // MARK: - Setup

    private func setupSelf() {
        backgroundColor = .white
        tableView.dataSource = dataSource
        tableView.delegate = delegate
        segmentControl.addTarget(self, action: #selector(segmentValueChanged(segment:)), for: .valueChanged)
    }

    private func setupLayout() {

        addSubview(segmentControl)
        segmentControl.setConstraints([
            segmentControl.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5.0),
            segmentControl.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5.0),
            segmentControl.topAnchor.constraint(equalTo: safeTopAnchor, constant: 10.0)
        ])

        addSubview(tableView)
        tableView.setConstraints([
            tableView.topAnchor.constraint(equalTo: segmentControl.bottomAnchor, constant: 15.0),
            tableView.bottomAnchor.constraint(equalTo: safeBottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])

        addSubview(loaderView)
        loaderView.setConstraints([
            loaderView.topAnchor.constraint(equalTo: tableView.topAnchor),
            loaderView.bottomAnchor.constraint(equalTo: tableView.bottomAnchor),
            loaderView.leadingAnchor.constraint(equalTo: tableView.leadingAnchor),
            loaderView.trailingAnchor.constraint(equalTo: tableView.trailingAnchor)
        ])
    }

    private func setupBindings() {

        viewModel?.startAnimating = { [weak self] in
            self?.loaderView.startLoading()
        }

        viewModel?.stopAnimating = { [weak self] in
            self?.loaderView.stopLoading()
        }

        viewModel?.dataLoaded = { [weak self] data in
            self?.dataSource.data = data
        }

        viewModel?.reloadData = { [weak self] in
            self?.tableView.reloadData()
        }

        viewModel?.segmentIndexSelected = { [weak self] index in
            self?.segmentControl.selectedSegmentIndex = index
        }

        viewModel?.segmentItemPrepared = { [weak self] items in
            self?.setupSegment(items: items)
        }

        delegate.didSelect = { [weak self] index in
            self?.viewModel?.select(index: index)
        }
    }

    private func setupSegment(items: [String]) {
        items.enumerated().forEach { index, item in
            segmentControl.insertSegment(withTitle: item, at: index, animated: false)
        }
    }

    @objc private func segmentValueChanged(segment: UISegmentedControl) {
        viewModel?.changeTable(with: segment.selectedSegmentIndex)
    }

    @objc private func refreshTable() {
        viewModel?.refreshData()
    }
}

private enum Subviews {

    static var segmentControl: UISegmentedControl {
        UISegmentedControl()
    }

    static var tableView: UITableView {
        let tableView = UITableView()
        tableView.register(CurrencyRowCellView.self)
        return tableView
    }

    static var loaderView: LoaderView {
        LoaderView()
    }
}
