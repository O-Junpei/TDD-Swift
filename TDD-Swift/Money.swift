class Money: Equatable {
    var amount: Int = 0
    
    static func == (lhs: Money, rhs: Money) -> Bool {
        return lhs.amount == rhs.amount && String(describing: type(of: lhs)) == String(describing: type(of: rhs))
    }
}
