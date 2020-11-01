import UIKit.UIViewController

final class CurrencyListViewController: BaseViewController<CurrencyListView> {

    // MARK: - Properties

    private let viewModel: CurrencyListViewModelType

    // MARK: - Initialization

    init(viewModel: CurrencyListViewModelType) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        setupSelf()
        setupBindings()
    }

    required init?(coder: NSCoder) {
        return nil
    }

    // MARK: - Setup

    override func loadView() {
        view = CurrencyListView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewDidLoad()
    }

    private func setupSelf() {
        loadedView?.viewModel = viewModel
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(refreshData))
    }

    private func setupBindings() {
        viewModel.title = { [weak self] title in
            self?.title = title
        }
    }

    @objc private func refreshData() {
        viewModel.refreshData()
    }
}
