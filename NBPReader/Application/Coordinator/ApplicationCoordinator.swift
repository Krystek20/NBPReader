import UIKit.UIWindow

final class ApplicationCoordinator: Coordinator {

    // MARK: - Properties

    private let window: UIWindow

    // MARK: - Initialization

    init(window: UIWindow) {
        self.window = window
    }

    // MARK: - Public

    override func start() {
        super.start()
        let currencyListCoordinator = CurrencyListCoordinator(window: window)
        navigate(to: currencyListCoordinator)
    }
}
