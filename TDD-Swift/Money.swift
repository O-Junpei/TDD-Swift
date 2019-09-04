class Money: Equatable, CustomStringConvertible, Expression {
    var amount: Int = 0
    var currency: String
    
    init(amount: Int, currency: String) {
        self.amount = amount
        self.currency = currency
    }
    
    var description: String {
        return "\(amount) \(currency.description))"
    }

    static func == (lhs: Money, rhs: Money) -> Bool {
        return lhs.amount == rhs.amount && lhs.currency == rhs.currency
    }

    static func dollar(amount: Int) -> Money {
        return Money(amount: amount, currency: "USD")
    }

    static func franc(amount: Int) -> Money {
        return Money(amount: amount, currency: "CHF")
    }

    func times(_ multiplier: Int) -> Money {
        return Money(amount: amount * multiplier, currency: currency)
    }
    
    func plus(added: Money) -> Expression {
        return Money(amount: amount + added.amount, currency: currency)
    }
}
