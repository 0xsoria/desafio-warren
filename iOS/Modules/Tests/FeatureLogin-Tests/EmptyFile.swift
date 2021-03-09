//
//
import CoreProviders
import XCTest
@testable import FeatureLogin

final class NetworkMockTest: XCTestCase {
    
    private var sut = NetworkMock()
    
    func testRequest() {
        let expectation = XCTestExpectation(description: "Expect Data not to be nil")
        self.sut.request(model: NetworkModel(urlString: String(), headers: nil, httpMethod: .post, body: Data())) { (result: Result<Data, NetworkError>) in
                switch result {
                case .success(let data):
                    expectation.fulfill()
                    let decoded = try? JSONDecoder().decode(UserToken.self, from: data)
                    XCTAssertNotNil(decoded)
                case .failure:
                    expectation.fulfill()
                    XCTFail()
                }
            }
        wait(for: [expectation], timeout: 4.0)
    }
}
