class Franc: Money {
    private let currency: String

    init(amount: Int) {
        currency = "CHF"
        super.init()
        self.amount = amount
    }

    override func times(_ multiplier: Int) -> Money {
        return Franc(amount: amount * multiplier)
    }
}
