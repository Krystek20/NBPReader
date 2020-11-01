import UIKit.UITableView

final class CurrencyListViewDelegate: NSObject, UITableViewDelegate {

    // MARK: - Properties

    var didSelect: PropertyOutput<Int>?

    // MARK: - Delegate

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        didSelect?(indexPath.row)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
