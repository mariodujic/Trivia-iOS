import XCTest
@testable import Trivia

class StorageServiceTests: XCTestCase {
    
    var sut: StorageService!
    
    override func setUp() {
        self.sut = StorageService()
    }
    
    func test_returns_stored_bool_value() {
        let fakeKey = "a"
        let expectedValue = true
        sut.setBool(key: fakeKey, value: expectedValue)
        let actualValue = sut.getBool(key: fakeKey)
        XCTAssertEqual(expectedValue, actualValue)
    }
}
