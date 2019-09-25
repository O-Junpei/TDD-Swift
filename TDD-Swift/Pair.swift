class Pair: Hashable {
    let from: String
    let to: String

    init(from: String, to: String) {
        self.from = from
        self.to = to
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(from)
        hasher.combine(to)
    }

    static func == (lhs: Pair, rhs: Pair) -> Bool {
        return lhs.from == rhs.from && lhs.to == rhs.to
    }
}
