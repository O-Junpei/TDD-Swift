class Money: Equatable {
    var amount: Int = 0
    var currency: String!
    
    init(amount: Int, currency: String) {
        self.amount = amount
        self.currency = currency
    }

    static func == (lhs: Money, rhs: Money) -> Bool {
        return lhs.amount == rhs.amount && String(describing: type(of: lhs)) == String(describing: type(of: rhs))
    }

    static func dollar(amount: Int) -> Dollar {
        return Dollar(amount: amount, currency: "USD")
    }

    static func franc(amount: Int) -> Franc {
        return Franc(amount: amount, currency: "CHF")
    }

    func times(_ multiplier: Int) -> Money {
        fatalError("Must be overridden")
    }
}
