import UIKit.UIViewController

final class ErrorAlertCoordinator: Coordinator {

    // MARK: - Properties

    var closed: Output?
    private let navigationController: UINavigationController
    private let error: Error

    // MARK: - Initialization

    init(navigationController: UINavigationController, error: Error) {
        self.navigationController = navigationController
        self.error = error
        super.init()
    }

    // MARK: - Managing

    override func start() {
        super.start()

        let alertController = UIAlertController(title: "Something went wrong", message: error.localizedDescription, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "Thanks", style: .default, handler: { [weak self] alert in
            self?.closed?()
        })
        alertController.addAction(alertAction)

        navigationController.present(alertController, animated: true)
    }
}
