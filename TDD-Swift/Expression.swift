protocol Expression {
    func plus(expression: Expression) -> Expression
    func reduce(bank: Bank, to: String) -> Money
}
