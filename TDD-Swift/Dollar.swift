class Dollar: Money {
    override init(amount: Int, currency: String) {
        super.init(amount: amount, currency: currency)
    }

    override func times(_ multiplier: Int) -> Money {
        return Money.dollar(amount: amount * multiplier)
    }
}
