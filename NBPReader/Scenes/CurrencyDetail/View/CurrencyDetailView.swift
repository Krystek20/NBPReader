import UIKit

final class CurrencyDetailView: UIView {

    // MARK: - Views

    private let fromTextField = Subviews.textField
    private let fromDatePicker = Subviews.datePicker
    private let toTextField = Subviews.textField
    private let toDatePicker = Subviews.datePicker
    private let submitButton = Subviews.submitButton
    private let tableView = Subviews.tableView
    private let loaderView = Subviews.loaderView

    // MARK: - Properties

    var viewModel: CurrencyDetailViewModelType? {
        didSet { setupBindings() }
    }
    private let dataSource: CurrencyListViewDataSource

    // MARK: - Initialization

    init(dataSource: CurrencyListViewDataSource = CurrencyListViewDataSource()) {
        self.dataSource = dataSource
        super.init(frame: .zero)
        setupSelf()
        setupLayout()
    }

    required init?(coder: NSCoder) {
        return nil
    }

    // MARK: - Setup

    private func setupSelf() {
        backgroundColor = .white
        tableView.dataSource = dataSource
        fromDatePicker.addTarget(self, action: #selector(fromDatePickerChanged(datePicker:)), for: .valueChanged)
        toDatePicker.addTarget(self, action: #selector(toDatePickerChanged(datePicker:)), for: .valueChanged)
        fromTextField.inputView = fromDatePicker
        toTextField.inputView = toDatePicker
        submitButton.addTarget(self, action: #selector(submitPressed), for: .touchUpInside)
    }

    private func setupLayout() {

        addSubview(fromTextField)
        fromTextField.setConstraints([
            fromTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5.0),
            fromTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5.0),
            fromTextField.topAnchor.constraint(equalTo: safeTopAnchor, constant: 15.0)
        ])

        addSubview(toTextField)
        toTextField.setConstraints([
            toTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5.0),
            toTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5.0),
            toTextField.topAnchor.constraint(equalTo: fromTextField.bottomAnchor, constant: 5.0)
        ])

        addSubview(submitButton)
        submitButton.setConstraints([
            submitButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5.0),
            submitButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5.0),
            submitButton.topAnchor.constraint(equalTo: toTextField.bottomAnchor, constant: 5.0),
            submitButton.heightAnchor.constraint(equalTo: toTextField.heightAnchor)
        ])

        addSubview(tableView)
        tableView.setConstraints([
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5.0),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5.0),
            tableView.topAnchor.constraint(equalTo: submitButton.bottomAnchor, constant: 5.0),
            tableView.bottomAnchor.constraint(equalTo: safeBottomAnchor)
        ])

        addSubview(loaderView)
        loaderView.setConstraints([
            loaderView.topAnchor.constraint(equalTo: tableView.topAnchor),
            loaderView.bottomAnchor.constraint(equalTo: tableView.bottomAnchor),
            loaderView.leadingAnchor.constraint(equalTo: tableView.leadingAnchor),
            loaderView.trailingAnchor.constraint(equalTo: tableView.trailingAnchor)
        ])
    }

    private func setupBindings() {

        viewModel?.startAnimating = { [weak self] in
            self?.loaderView.startLoading()
        }

        viewModel?.stopAnimating = { [weak self] in
            self?.loaderView.stopLoading()
        }

        viewModel?.fromDateSet = { [weak self] date in
            self?.fromDatePicker.date = date
        }

        viewModel?.fromTextSet = { [weak self] text in
            self?.fromTextField.text = text
        }

        viewModel?.toTextSet = { [weak self] text in
            self?.toTextField.text = text
        }

        viewModel?.toDateSet = { [weak self] date in
            self?.toDatePicker.date = date
        }

        viewModel?.dataLoaded = { [weak self] data in
            self?.dataSource.data = data
        }

        viewModel?.reloadData = { [weak self] in
            self?.tableView.reloadData()
        }
    }

    @objc private func fromDatePickerChanged(datePicker: UIDatePicker) {
        viewModel?.setFromDate(datePicker.date)
    }

    @objc private func toDatePickerChanged(datePicker: UIDatePicker) {
        viewModel?.setToDate(datePicker.date)
    }

    @objc private func submitPressed() {
        viewModel?.submit()
    }

    @objc private func refreshData() {
        viewModel?.refreshData()
    }
}

private enum Subviews {

    static var textField: UITextField {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.font = .systemFont(ofSize: 11, weight: .semibold)
        return textField
    }

    static var datePicker: UIDatePicker {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.maximumDate = Date()
        if #available(iOS 13.4, *) {
            datePicker.preferredDatePickerStyle = .wheels
        }
        return datePicker
    }

    static var stackView: UIStackView {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        return stackView
    }

    static var tableView: UITableView {
        let tableView = UITableView()
        tableView.keyboardDismissMode = .onDrag
        tableView.register(CurrencyRowCellView.self)
        return tableView
    }

    static var submitButton: UIButton {
        let button = UIButton()
        button.setTitle("Submit", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14, weight: .regular)
        button.layer.cornerRadius = 5.0
        button.layer.borderWidth = 1.0
        button.layer.borderColor = UIColor.black.cgColor
        return button
    }

    static var loaderView: LoaderView {
        LoaderView()
    }
}
