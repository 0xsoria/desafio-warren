//
//  File.swift
//  
//
//  Created by Gabriel Soria Souza on 05/03/21.
//

import CoreProviders
import XCTest
@testable import FeatureLogin

final class LoginSystemTests: XCTestCase {
    
    private var sut: LoginSystem?
    
    func testLoginSuccess() {
        let expectation = XCTestExpectation(description: "Expect Data not to be nil")
        self.sut = LoginSystem(network: NetworkMock())
        self.sut?.login(user: User(email: String(), password: String()), completion: { (result: Result<UserToken, Error>) in
            switch result {
            case .success(let user):
                expectation.fulfill()
                XCTAssertFalse(user.accessToken.isEmpty)
                XCTAssertFalse(user.refreshToken.isEmpty)
            case .failure:
                expectation.fulfill()
                XCTFail()
            }
        })
        wait(for: [expectation], timeout: 2.1)
    }
    
    func testLoginFailure() {
        let expectation = XCTestExpectation(description: "Expect Data not to be nil")
        self.sut = LoginSystem(network: NetworkMockError())
        self.sut?.login(user: User(email: String(), password: String()), completion: { (result: Result<UserToken, Error>) in
            switch result {
            case .success:
                expectation.fulfill()
                XCTFail()
            case .failure(let error):
                expectation.fulfill()
                XCTAssertNotNil(error as? NetworkError)
            }
        })
        wait(for: [expectation], timeout: 2.1)
    }
}
