class Dollar: Money {

    init(amount: Int) {
        super.init()
        self.amount = amount
    }

    func times(_ multiplier: Int) -> Dollar {
        return Dollar(amount: amount * multiplier)
    }
}
