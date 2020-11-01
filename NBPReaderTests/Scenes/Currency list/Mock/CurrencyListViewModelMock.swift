import Foundation
@testable import NBPReader

final class CurrencyListViewModelMock: CurrencyListViewModelType {

    // MARK: - Inputs
    
    func loadCurrencyList() {
        
    }

    func viewDidLoad() {

    }

    func changeTable(with: Int) {

    }

    func refreshData() {

    }

    func select(index: Int) {

    }

    // MARK: - Outputs

    var startAnimating: Output?
    var stopAnimating: Output?
    var dataLoaded: PropertyOutput<[CurrencyCellData]>?
    var reloadData: Output?
    var segmentItemPrepared: PropertyOutput<[String]>?
    var segmentIndexSelected: PropertyOutput<Int>?
    var endRefreshing: Output?
    var currencySelected: PropertyOutput<CurrencySelected>?
    var title: PropertyOutput<String>?
    var errorHandled: PropertyOutput<Error>?
}
