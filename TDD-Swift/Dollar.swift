class Dollar: Money {

    init(amount: Int) {
        super.init()
        self.amount = amount
    }

    override func times(_ multiplier: Int) -> Money {
        return Dollar(amount: amount * multiplier)
    }
}
