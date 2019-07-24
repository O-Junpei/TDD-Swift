class Franc: Money {
    
    init(amount: Int) {
        super.init()
        self.amount = amount
    }
    
    func times(_ multiplier: Int) -> Franc {
        return Franc(amount: amount * multiplier)
    }
}
