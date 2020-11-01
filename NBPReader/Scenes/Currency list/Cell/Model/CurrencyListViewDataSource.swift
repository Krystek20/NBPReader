import UIKit.UITableView

final class CurrencyListViewDataSource: NSObject, UITableViewDataSource {

    // MARK: - Properties

    var data = [CurrencyCellData]()

    // MARK: - UITableViewDataSource

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        data.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(CurrencyRowCellView.self, for: indexPath)
        guard let currencyRowCellView = cell as? CurrencyRowCellView,
              data.indices.contains(indexPath.row) else { return cell }
        let rowData = data[indexPath.row]
        currencyRowCellView.viewModel = CurrencyRowCellViewModel(data: rowData)
        return currencyRowCellView
    }
}
