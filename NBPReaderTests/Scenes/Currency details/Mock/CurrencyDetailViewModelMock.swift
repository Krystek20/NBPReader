import Foundation
@testable import NBPReader

final class CurrencyDetailViewModelMock: CurrencyDetailViewModelType {

    // MARK: - Inputs

    func viewDidLoad() {

    }

    func setFromDate(_: Date) {

    }

    func setToDate(_: Date) {

    }

    func submit() {

    }

    func refreshData() {

    }

    // MARK: - Outputs

    var startAnimating: Output?
    var stopAnimating: Output?
    var closed: Output?
    var fromDateSet: PropertyOutput<Date>?
    var toDateSet: PropertyOutput<Date>?
    var dataLoaded: PropertyOutput<[CurrencyCellData]>?
    var reloadData: Output?
    var fromTextSet: PropertyOutput<String>?
    var toTextSet: PropertyOutput<String>?
    var title: PropertyOutput<String>?
    var errorHandled: PropertyOutput<Error>?
}
