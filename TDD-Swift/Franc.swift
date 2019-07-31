class Franc: Money {
    
    init(amount: Int) {
        super.init()
        self.amount = amount
    }
    
    override func times(_ multiplier: Int) -> Money {
        return Franc(amount: amount * multiplier)
    }
}
