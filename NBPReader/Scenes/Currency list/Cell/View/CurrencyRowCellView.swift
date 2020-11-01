import UIKit
import Combine

final class CurrencyRowCellView: UITableViewCell {

    // MARK: - Views

    private let dateLabel = Subviews.dataLabel
    private let nameLabel = Subviews.nameLabel
    private let valueLabel = Subviews.valueLabel
    private let stackView = Subviews.stackView

    // MARK: - Properties

    var viewModel: CurrencyRowCellViewModelType? {
        didSet { setupBindings() }
    }

    // MARK: - Initialization

    override init(style: CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupSelf()
        setupLayout()
    }

    required init?(coder: NSCoder) {
        return nil
    }

    // MARK: - Setup

    private func setupSelf() {
        selectionStyle = .default
    }

    private func setupLayout() {

        stackView.addArrangedSubview(dateLabel)
        stackView.addArrangedSubview(nameLabel)
        stackView.addArrangedSubview(valueLabel)

        contentView.addSubview(stackView)
        stackView.setConstraints([
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5.0),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5.0),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5.0),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5.0)
        ])
    }

    private func setupBindings() {

        viewModel?.effectiveDateSet = { [weak self] data in
            self?.dateLabel.text = data
        }

        viewModel?.nameSet = { [weak self] name in
            self?.nameLabel.text = name
        }

        viewModel?.valueSet = { [weak self] value in
            self?.valueLabel.text = value
        }

        viewModel?.isNameLabelHidden = { [weak self] isHidden in
            self?.nameLabel.isHidden = isHidden
        }
    }
}

private enum Subviews {

    static var stackView: UIStackView {
        let stackView = UIStackView()
        stackView.spacing = 5.0
        stackView.axis = .vertical
        return stackView
    }

    static var dataLabel: UILabel {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .semibold)
        return label
    }

    static var nameLabel: UILabel {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .regular)
        return label
    }

    static var valueLabel: UILabel {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.numberOfLines = 2
        return label
    }
}
