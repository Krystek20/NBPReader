import XCTest
@testable import NBPReader

final class CurrencyDetailViewControllerTests: XCTestCase {

    private var sut: CurrencyDetailViewController!

    override func setUp() {
        super.setUp()
        let viewModel = CurrencyDetailViewModelMock()
        sut = CurrencyDetailViewController(currencyDetailViewModel: viewModel)
    }

    func testCurrencyListViewControllerShouldSetView() {
        // when
        sut.loadViewIfNeeded()

        // then
        XCTAssertNotNil(sut.loadedView)
    }

    func testCurrencyListViewControllerConnectedViewModelToViewIsNotNil() {
        // when
        sut.loadViewIfNeeded()

        // then
        XCTAssertNotNil(sut.loadedView?.viewModel)
    }
}
