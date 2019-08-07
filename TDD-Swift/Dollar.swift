class Dollar: Money {
    private let currency: String

    init(amount: Int) {
        currency = "USD"
        super.init()
        self.amount = amount
    }

    override func times(_ multiplier: Int) -> Money {
        return Dollar(amount: amount * multiplier)
    }
}
