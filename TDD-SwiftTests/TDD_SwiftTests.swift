import XCTest
@testable import TDD_Swift

class TDD_SwiftTests: XCTestCase {
    func testMultiplication() {
         let five: Money = Money.dollar(amount: 5)
         // XCTAssertEqual(Money.dollar(amount: 10), five.times(multiplier: 2))
         XCTAssertEqual(Money.dollar(amount: 10), five.times(multiplier: 2).reduce(bank: Bank(), to: "USD"))
         // XCTAssertEqual(Money.dollar(amount: 15), five.times(multiplier: 3))
         XCTAssertEqual(Money.dollar(amount: 15), five.times(multiplier: 3).reduce(bank: Bank(), to: "USD"))
     }

     func testEquality() {
         XCTAssertTrue(Money.dollar(amount: 5) == Money.dollar(amount: 5))
         XCTAssertFalse(Money.dollar(amount: 5) == Money.dollar(amount: 6))
         XCTAssertFalse(Money.franc(amount: 5) == Money.dollar(amount: 5))
     }

     func testCurrency() {
         XCTAssertEqual("USD", Money.dollar(amount: 1).currency)
         XCTAssertEqual("CHF", Money.franc(amount: 1).currency)
     }
     
     func testSimpleAddition() {
         let five: Money = Money.dollar(amount: 5)
         let sum: Expression = five.plus(addend: five)
         let bank: Bank = Bank()
         let reduced: Money = bank.reduce(source: sum, to: "USD")
         XCTAssertEqual(Money.dollar(amount: 10), reduced)
     }
     
     func testPlusReturnSum() {
         let five: Money = Money.dollar(amount: 5)
         let result: Expression = five.plus(addend: five)
         let sum: Sum = result as! Sum
         // XCTAssertEqual(five, sum.added)
         XCTAssertEqual(five, sum.addend.reduce(bank: Bank(), to: "USD"))
     }
     
     func testResuceSum() {
         let sum: Expression = Sum(augend: Money.dollar(amount: 3), addend: Money.dollar(amount: 4))
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
     
     func testMixedAddition() {
         let fiveBucks: Expression = Money.dollar(amount: 5)
         let tenFrancs: Expression = Money.franc(amount: 10)
         let bank: Bank = Bank()
         bank.addRate(from: "CHF", to: "USD", rate: 2)
         let result: Money = bank.reduce(source: fiveBucks.plus(addend: tenFrancs), to: "USD")
         XCTAssertEqual(Money.dollar(amount: 10), result)
     }
     
     func testSumPlusMoney() {
         let fiveBucks: Expression = Money.dollar(amount: 5)
         let tenFrancs: Expression = Money.franc(amount: 10)
         let bank: Bank = Bank()
         bank.addRate(from: "CHF", to: "USD", rate: 2)
         let sum: Expression = Sum(augend: fiveBucks, addend: tenFrancs).plus(addend: fiveBucks)
         let result = bank.reduce(source: sum, to: "USD")
         XCTAssertEqual(Money.dollar(amount: 15), result)
     }
     
     func testSumTimes() {
         let fiveBucks: Expression = Money.dollar(amount: 5)
         let tenFrancs: Expression = Money.franc(amount: 10)
         let bank: Bank = Bank()
         bank.addRate(from: "CHF", to: "USD", rate: 2)
         let sum: Expression = Sum(augend: fiveBucks, addend: tenFrancs).times(multiplier: 2)
         let result: Money = bank.reduce(source: sum, to: "USD")
         XCTAssertEqual(Money.dollar(amount: 20), result)
     }
}
