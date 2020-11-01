import UIKit

final class CurrencyDetailViewController: BaseViewController<CurrencyDetailView> {

    // MARK: - Properties

    private var viewModel: CurrencyDetailViewModelType

    // MARK: - Initialization

    init(currencyDetailViewModel: CurrencyDetailViewModelType) {
        self.viewModel = currencyDetailViewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        return nil
    }

    // MARK: - Setup

    override func loadView() {
        view = CurrencyDetailView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupBindings()
        viewModel.viewDidLoad()
    }

    private func setupViews() {
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
