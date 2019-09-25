protocol Expression {
    func reduce(bank: Bank, to: String) -> Money
}
