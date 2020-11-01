import UIKit.UIWindow

final class CurrencyListCoordinator: Coordinator {

    // MARK: - Properties

    private let window: UIWindow

    // MARK: - Initialization

    init(window: UIWindow) {
        self.window = window
        super.init()
    }

    // MARK: - Managing

    override func start() {
        super.start()

        let currencyListViewModel = CurrencyListViewModel()
        let currencyListViewController = CurrencyListViewController(viewModel: currencyListViewModel)
        let navigationController = UINavigationController(rootViewController: currencyListViewController)

        currencyListViewModel.currencySelected = { [weak navigationController] currencySelected in
            guard let navigationController = navigationController else { return }
            self.showCurrencyDetail(on: navigationController, currencySelected: currencySelected)
        }

        currencyListViewModel.errorHandled = { [weak navigationController] error in
            guard let navigationController = navigationController else { return }
            self.showErrorView(on: navigationController, error: error)
        }

        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }

    private func showCurrencyDetail(on controller: UINavigationController, currencySelected: CurrencySelected) {
        let resourceGalleryCoordinator = CurrencyDetailCoordinator(navigationController: controller, currencySelected: currencySelected)

        resourceGalleryCoordinator.closed = { [weak self, weak resourceGalleryCoordinator] in
            guard let resourceGalleryCoordinator = resourceGalleryCoordinator else { return }
            self?.remove(resourceGalleryCoordinator)
        }

        navigate(to: resourceGalleryCoordinator)
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
