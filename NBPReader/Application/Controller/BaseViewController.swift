import UIKit.UIViewController

class BaseViewController<T>: UIViewController where T: UIView {

    // MARK - Properties

    var loadedView: T? {
        view as? T
    }

    // MARK: - Managing

    override func loadView() {
        view = T()
    }
}
