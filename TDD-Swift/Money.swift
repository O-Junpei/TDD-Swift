class Money: Equatable {
    var amount: Int = 0

    static func == (lhs: Money, rhs: Money) -> Bool {
        return lhs.amount == rhs.amount && String(describing: type(of: lhs)) == String(describing: type(of: rhs))
    }

    static func doller(amount: Int) -> Dollar {
        return Dollar(amount: amount)
    }

    static func franc(amount: Int) -> Franc {
        return Franc(amount: amount)
    }

    func times(_ multiplier: Int) -> Money {
        let money = Money()
        money.amount = self.amount * multiplier
        return money
    }

    func currency() -> String {
        fatalError("Must be overridden")
    }
}
