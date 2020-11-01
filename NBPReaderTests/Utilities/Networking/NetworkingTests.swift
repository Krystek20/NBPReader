import XCTest
@testable import NBPReader

final class NetworkingTests: XCTestCase {

    private var dataTaskMock: NetworkingSessionDataTaskMock!
    private var sessionMock: NetworkingSessionMock!
    private var sut: NetworkingType!
    private let endpoint = TestEndpoint.correct

    override func setUp() {
        super.setUp()
        dataTaskMock = NetworkingSessionDataTaskMock()
        sessionMock = NetworkingSessionMock(networkingSessionDataTask: dataTaskMock)
        sut = Networking(session: sessionMock)
    }

    override func tearDown() {
        super.tearDown()
        sessionMock = nil
        dataTaskMock = nil
        sut = nil
    }

    func testNetworkingRequestCallRequestSession() {
        // given
        let completion: (Result<DecodableData, Error>) -> Void = { _ in }

        // when
        sut.request(with: endpoint, completion)

        // then
        XCTAssertEqual(sessionMock.networkingTaskCount, 1)
    }

    func testNetworkingRequestCallResumeDataTask() {
        // given
        let completion: (Result<DecodableData, Error>) -> Void = { _ in }

        // when
        sut.request(with: endpoint, completion)

        // then
        XCTAssertEqual(dataTaskMock.resumeCalled, 1)
    }

    func testNetworkingRequestSuccessCallsResultWithDecodableObject() {
        // given
        let expectation = XCTestExpectation()
        let completion: (Result<DecodableData, Error>) -> Void = { [weak self] result in
            self?.verifySuccessResult(result, expected: DecodableData(status: 1))
            expectation.fulfill()
        }

        // when
        sut.request(with: endpoint, completion)
        sessionMock.resumeDataTask(with: JsonData.decodableData)

        // then
        wait(for: [expectation], timeout: 0.01)
    }

    func testNetworkingRequestFailureCallsResultWithEmptyDataError() {
        // given
        let expectation = XCTestExpectation()
        let completion: (Result<DecodableData, Error>) -> Void = { [weak self] result in
            self?.verifyFailureResult(result, expected: NetworkingError.emptyData)
            expectation.fulfill()
        }

        // when
        sut.request(with: endpoint, completion)
        sessionMock.resumeDataTask(with: nil)

        // then
        wait(for: [expectation], timeout: 0.01)
    }

    func testNetworkingRequestFailureCallsResultWithNetworkError() {
        // given
        enum FakeError: Error {
            case someError
        }
        let expectation = XCTestExpectation()
        let completion: (Result<DecodableData, Error>) -> Void = { [weak self] result in
            self?.verifyFailureResult(result, expected: FakeError.someError)
            expectation.fulfill()
        }

        // when
        sut.request(with: endpoint, completion)
        sessionMock.resumeError(with: FakeError.someError)

        // then
        wait(for: [expectation], timeout: 0.01)
    }

    func testNetworkingRequestFailureCallsResultWithBadUrlError() {
        // given
        let expectation = XCTestExpectation()
        let completion: (Result<DecodableData, Error>) -> Void = { [weak self] result in
            self?.verifyFailureResult(result, expected: NetworkingError.badUrl)
            expectation.fulfill()
        }

        // when
        sut.request(with: TestEndpoint.fail, completion)

        // then
        wait(for: [expectation], timeout: 0.01)
    }

    func testNetworkingRequestFailureCallsResultWithEmptyListWhen404Error() {
        // given
        let expectation = XCTestExpectation()
        let completion: (Result<DecodableData, Error>) -> Void = { [weak self] result in
            self?.verifyFailureResult(result, expected: NetworkingError.emptyList)
            expectation.fulfill()
        }
        let response = HTTPURLResponse(url: URL(fileURLWithPath: "fake.path"), statusCode: 404, httpVersion: nil, headerFields: nil)

        // when
        sut.request(with: TestEndpoint.correct, completion)
        sessionMock.resumeResponse(with: response)

        // then
        wait(for: [expectation], timeout: 0.01)
    }
}
