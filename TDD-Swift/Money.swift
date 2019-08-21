class Money: Equatable, CustomStringConvertible {
    var amount: Int = 0
    var currency: String
    
    init(amount: Int, currency: String) {
        self.amount = amount
        self.currency = currency
    }
    
    var description: String {
        return "\(amount) \(String(describing: currency))"
    }

    static func == (lhs: Money, rhs: Money) -> Bool {
        return lhs.amount == rhs.amount && lhs.currency == rhs.currency
    }

    static func dollar(amount: Int) -> Dollar {
        return Dollar(amount: amount, currency: "USD")
    }

    static func franc(amount: Int) -> Franc {
        return Franc(amount: amount, currency: "CHF")
    }

    func times(_ multiplier: Int) -> Money {
        return Money(amount: amount * multiplier, currency: currency)
    }
}
