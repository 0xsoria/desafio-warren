//
//  File.swift
//  
//
//  Created by Gabriel Soria Souza on 12/03/21.
//

import XCTest
@testable import Goals

final class AsyncOperationTests: XCTestCase {
    
    private let queue = OperationQueue()
    
    func test() throws {
        let expectation = XCTestExpectation()
        let bundle = Bundle.module.url(forResource: "placeholder",
                                     withExtension: "jpeg")
        
        let url = try XCTUnwrap(bundle)
        let networkOperation = NetworkImageOperation(url: url)
        networkOperation.completionBlock = {
            DispatchQueue.main.async {
                expectation.fulfill()
                XCTAssertNotNil(networkOperation.image)
            }
        }
        queue.addOperation(networkOperation)
        wait(for: [expectation], timeout: 2.1)
    }
}
