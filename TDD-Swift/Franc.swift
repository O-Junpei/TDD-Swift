class Franc: Equatable {
    var amount: Int = 0
    
    init(amount: Int) {
        self.amount = amount
    }
    
    func times(_ multiplier: Int) -> Franc {
        return Franc(amount: amount * multiplier)
    }
    
    static func == (lhs: Franc, rhs: Franc) -> Bool {
        return lhs.amount == rhs.amount
    }
}
