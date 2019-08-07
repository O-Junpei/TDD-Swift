class Franc: Money {
    override init(amount: Int, currency: String) {
        super.init(amount: amount, currency: currency)
    }

    override func times(_ multiplier: Int) -> Money {
        return Money.franc(amount: amount * multiplier)
    }
}
