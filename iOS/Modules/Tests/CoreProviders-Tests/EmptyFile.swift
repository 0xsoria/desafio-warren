
import XCTest
@testable import CoreProviders

final class PersistingServiceTests: XCTestCase {
    
    private var sut = PersistingService()

    func testSavePassword() {
        XCTAssertNoThrow(try self.sut.save(account: "mail@mail.com", password: "Mail3$", service: "www.mail.com"))
    }
}
