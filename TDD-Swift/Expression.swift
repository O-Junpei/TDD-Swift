protocol Expression {
    func times(multiplier: Int) -> Expression
    func plus(expression: Expression) -> Expression
    func reduce(bank: Bank, to: String) -> Money
}
