import UIKit.UIViewController

final class CurrencyDetailCoordinator: Coordinator {

    // MARK: - Properties

    var closed: Output?
    private let navigationController: UINavigationController
    private let currencySelected: CurrencySelected

    // MARK: - Initialization

    init(navigationController: UINavigationController, currencySelected: CurrencySelected) {
        self.navigationController = navigationController
        self.currencySelected = currencySelected
        super.init()
    }

    // MARK: - Managing

    override func start() {
        super.start()

        let currencyDetailViewModel = CurrencyDetailViewModel(currencySelected: currencySelected)
        currencyDetailViewModel.closed = { [weak self] in
            self?.closed?()
        }
        currencyDetailViewModel.errorHandled = { [weak self, weak navigationController] error in
            guard let navigationController = navigationController else { return }
            self?.showErrorView(on: navigationController, error: error)
        }
        let currencyDetailViewController = CurrencyDetailViewController(currencyDetailViewModel: currencyDetailViewModel)

        navigationController.pushViewController(currencyDetailViewController, animated: true)
    }

    private func showErrorView(on controller: UINavigationController, error: Error) {
        let errorAlertCoordinator = ErrorAlertCoordinator(navigationController: controller, error: error)

        errorAlertCoordinator.closed = { [weak self, weak errorAlertCoordinator] in
            guard let errorAlertCoordinator = errorAlertCoordinator else { return }
            self?.remove(errorAlertCoordinator)
        }

        navigate(to: errorAlertCoordinator)
    }
}
