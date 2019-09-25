import XCTest
@testable import TDD_Swift

class TDD_SwiftTests: XCTestCase {

    func testMultiplication() {
        let five: Money = Money.dollar(amount: 5)
        XCTAssertEqual(Money.dollar(amount: 10), five.times(2))
        XCTAssertEqual(Money.dollar(amount: 15), five.times(3))
    }
    
    func testEquality() {
        XCTAssertTrue(Money.dollar(amount: 5) == Money.dollar(amount: 5))
        XCTAssertFalse(Money.dollar(amount: 5) == Money.dollar(amount: 6))
        XCTAssertFalse(Money.franc(amount: 5) == Money.dollar(amount: 5))
    }
    
    func testFrancMultiplication() {
        let five: Money = Money.franc(amount: 5)
        XCTAssertEqual(Money.franc(amount: 10), five.times(2))
        XCTAssertEqual(Money.franc(amount: 15), five.times(3))
    }
    
    func testCurrency() {
        XCTAssertEqual("USD", Money.dollar(amount: 1).currency)
        XCTAssertEqual("CHF", Money.franc(amount: 1).currency)
    }
    
    func testSimpleAdditon() {
        let five: Money = Money.dollar(amount: 5)
        let sum: Expression = five.plus(added: five)
        let bank: Bank = Bank()
        let reduced: Money = bank.reduce(source: sum, to: "USD")
        XCTAssertEqual(Money.dollar(amount: 10), reduced)
    }
    
    func testPlusReturnSum() {
        let five: Money = Money.dollar(amount: 5)
        let result: Expression = five.plus(added: five)
        let sum: Sum = result as! Sum
        XCTAssertEqual(five, sum.added)
        XCTAssertEqual(five, sum.added)
    }
    
    func testReduceSum() {
        let sum: Expression = Sum(augend: Money.dollar(amount: 3), added: Money.dollar(amount: 4))
        let bank: Bank = Bank()
        let result: Money = bank.reduce(source: sum, to: "USD")
        XCTAssertEqual(Money.dollar(amount: 7), result)
    }
    
    func testReduceMoney() {
        let bank: Bank = Bank()
        let result: Money = bank.reduce(source: Money.dollar(amount: 1), to: "USD")
        XCTAssertEqual(Money.dollar(amount: 1), result)
    }
    
    func testReduceMoneyDifferentCurrency() {
        let bank: Bank = Bank()
        bank.addRate(from: "CHF", to: "USD", rate: 2)
        let result: Money = bank.reduce(source: Money.franc(amount: 2), to: "USD")
        XCTAssertEqual(Money.dollar(amount: 1), result)
    }
    
    func testIdentityRate() {
        XCTAssertEqual(1, Bank().rate(from: "USD", to: "USD"))
    }
}
