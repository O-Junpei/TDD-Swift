class Sum: Expression {
    let augend: Expression
    let added: Expression
    
    init(augend: Expression, added: Expression) {
        self.augend = augend
        self.added = added
    }
    
    func plus(expression: Expression) -> Expression {
        // 仮実装
        fatalError()
    }
    
    func reduce(bank: Bank, to: String) -> Money {
        let amount: Int = augend.reduce(bank: bank, to: to).amount + added.reduce(bank: bank, to: to).amount
        return Money(amount: amount, currency: to)
    }
}
