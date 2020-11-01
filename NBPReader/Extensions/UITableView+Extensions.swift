import UIKit.UITableView

extension UITableView {

    func register(_ cell: UITableViewCell.Type) {
        register(cell, forCellReuseIdentifier: cell.reuseIdentifier)
    }

    func dequeueReusableCell(_ cell: UITableViewCell.Type, for indexPath: IndexPath) -> UITableViewCell {
        dequeueReusableCell(withIdentifier: cell.reuseIdentifier, for: indexPath)
    }
}
