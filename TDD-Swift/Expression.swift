protocol Expression {
    func times(multiplier: Int) -> Expression
    func plus(addend: Expression) -> Expression
    func reduce(bank: Bank, to: String) -> Money
}
