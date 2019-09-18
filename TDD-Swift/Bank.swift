import UIKit

class Bank {
    func reduce(source: Expression, to: String) -> Money {
        return source.reduce(to: to)
    }
}
