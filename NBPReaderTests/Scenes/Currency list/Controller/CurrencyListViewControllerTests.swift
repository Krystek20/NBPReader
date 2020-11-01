import XCTest
@testable import NBPReader

final class CurrencyListViewControllerTests: XCTestCase {

    private var sut: CurrencyListViewController!

    override func setUp() {
        super.setUp()
        let viewModel = CurrencyListViewModelMock()
        sut = CurrencyListViewController(viewModel: viewModel)
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
