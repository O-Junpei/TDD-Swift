class Sum: Expression {
    let augend: Expression
    let addend: Expression
    
    init(augend: Expression, added: Expression) {
        self.augend = augend
        self.addend = added
    }
    
    func times(multiplier: Int) -> Expression {
        return Sum(augend: augend.times(multiplier: multiplier), added: addend.times(multiplier: multiplier))
    }
    
    func plus(expression addend: Expression) -> Expression {
        return Sum(augend: self, added: addend)
    }
    
    func reduce(bank: Bank, to: String) -> Money {
        let amount: Int = augend.reduce(bank: bank, to: to).amount + addend.reduce(bank: bank, to: to).amount
        return Money(amount: amount, currency: to)
    }
}
