import XCTest
@testable import TDD_Swift

class TDD_SwiftTests: XCTestCase {

    func testMultiplication() {
        let five: Dollar = Dollar(amount: 5)
        XCTAssertEqual(Dollar(amount: 10), five.times(2))
        XCTAssertEqual(Dollar(amount: 15), five.times(3))
    }
    
    func testEquality() {
        XCTAssertTrue(Dollar(amount: 5) == Dollar(amount: 5))
        XCTAssertFalse(Dollar(amount: 5) == Dollar(amount: 6))
    }
    
    func testFrancMultiplication() {
        let five = Franc(amount: 5)
        XCTAssertEqual(Franc(amount: 10), five.times(2))
        XCTAssertEqual(Franc(amount: 15), five.times(3))
    }
}
