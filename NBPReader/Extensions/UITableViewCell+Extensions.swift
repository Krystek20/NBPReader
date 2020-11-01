import UIKit.UITableViewCell

extension UITableViewCell {
    static var reuseIdentifier: String {
        String(describing: self)
    }
}
