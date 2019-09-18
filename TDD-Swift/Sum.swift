class Sum: Expression {
    let augend: Money
    let added: Money
    
    init(augend: Money, added: Money) {
        self.augend = augend
        self.added = added
    }
    
    func reduce(to: String) -> Money {
        let amount: Int = augend.amount + added.amount
        return Money(amount: amount, currency: to)
    }
}
