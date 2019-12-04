class Sum: Expression {
    let augend: Expression
    let addend: Expression
    
    init(augend: Expression, addend: Expression) {
        self.augend = augend
        self.addend = addend
    }
    
    func times(multiplier: Int) -> Expression {
        return Sum(augend: augend.times(multiplier: multiplier), addend: addend.times(multiplier: multiplier))
    }
    
    func plus(addend: Expression) -> Expression {
        return Sum(augend: self, addend: addend)
    }
    
    func reduce(bank: Bank, to: String) -> Money {
        let amount: Int = augend.reduce(bank: bank, to: to).amount + addend.reduce(bank: bank, to: to).amount
        return Money(amount: amount, currency: to)
    }
}

