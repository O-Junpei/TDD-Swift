弊社弊チームでは TDD を習得するために Kent Beck(著), 和田 卓人(翻訳)の [テスト駆動開発](https://www.amazon.co.jp/%E3%83%86%E3%82%B9%E3%83%88%E9%A7%86%E5%8B%95%E9%96%8B%E7%99%BA-Kent-Beck/dp/4274217884) の輪読をしています。
[テスト駆動開発](https://www.amazon.co.jp/%E3%83%86%E3%82%B9%E3%83%88%E9%A7%86%E5%8B%95%E9%96%8B%E7%99%BA-Kent-Beck/dp/4274217884) はとても良い本でした。
「写経ではなく別の言語で挑戦することで、TDDをより深く習得したい」 & 「Swift自体の勉強がしたい」と思い、Swift でテスト駆動開発(TDD)に挑戦してみました。
プロジェクトファイルはこちらに置いてあります。[O-Junpei/TDD-Swift](https://github.com/O-Junpei/TDD-Swift)

## 方針と注意事項
本文の内容やコードは、著作権を考慮して極力載せず、Swift のコードとテストのTODOリストだけでやっていきたいと思っています。
もし関係者の方々から注意喚起があれば記事をすぐに削除します。
言語が異なるので進め方が多少異なる場合があります。  

## 事前準備
Include Unit Test にチェックを入れ、テスト環境が整ったプロジェクトを作成します。

<img width="726" alt="スクリーンショット 2019-11-13 11.22.02.png" src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/63855/44cbac48-ef8e-9d3b-af9d-8ca0f2d39594.png">


# 第1章 仮実装

米ドルやフランを扱うことのできる多国通貨オプジェクトを作成します。
第1章では米ドルの掛け算を実装していきます。
あまり詰まることがなく、Java の実装を参考に実装をすることができました。

### TODOリスト
- $5 + 10CHF = $10 (レートが2:1の場合)
- $5 * 2 = $10



``` Dollar.swift
import Foundation

class Dollar {
    var amount: Int

    init(amount: Int) {
        self.amount = amount
    }

    func times(multiplier: Int) {
        amount *= multiplier
    }
}
```


``` TDD_SwiftTests.swift
import XCTest
@testable import TDD_Swift

class TDD_SwiftTests: XCTestCase {

    func testMultiplication() {
        let five: Dollar = Dollar(amount: 5)
        five.times(multiplier: 2)
        XCTAssertEqual(10, five.amount)
    }
}
```


# 第2章 明白な実装

2章もあまり詰まることが無く、実装することができました。

### TODOリスト
- $5 + 10CHF = $10 (レートが2:1の場合)
- ~~$5 * 2 = $10~~
- amountをprivateにする
- Dollarの副作用どうする？
- Moneyの丸め処理どうする？


``` Dollar.swift
import Foundation

class Dollar {
    var amount: Int

    init(amount: Int) {
        self.amount = amount
    }

    func times(multiplier: Int) -> Dollar {
        return Dollar(amount: amount * multiplier)
    }
}
```

``` TDD_SwiftTests.swift
import XCTest
@testable import TDD_Swift

class TDD_SwiftTests: XCTestCase {

    func testMultiplication() {
        let five: Dollar = Dollar(amount: 5)
        var product: Dollar = five.times(multiplier: 2)
        XCTAssertEqual(10, product.amount)
        product = five.times(multiplier: 3)
        XCTAssertEqual(15, product.amount)
    }
}
```


# 第3章 三角測量

Java の実装では `equals` メソッドで$ドル同士を比較しています。（Java ではプリミティブ型の比較に `==`演算子、参照型の比較に `equals`メソッドを使用する。）
Swift の実装では `==`演算子を使用して比較しました。
`Equatable` プロトコルに準拠することで `==`演算子を使用することができます。

### TODOリスト
- $5 + 10CHF = $10（レートが2:1の場合）
- ~~$5 * 2 = $10~~
- amountをprivateにする
- Dollarの副作用どうする？
- Moneyの丸め処理どうする？
- equals()


``` Dollar.swift
import Foundation

class Dollar: Equatable {
    var amount: Int

    init(amount: Int) {
        self.amount = amount
    }

    func times(multiplier: Int) -> Dollar {
        return Dollar(amount: amount * multiplier)
    }

    static func == (lhs: Dollar, rhs: Dollar) -> Bool {
        lhs.amount == rhs.amount
    }
}
```


``` TDD_SwiftTests.swift
import XCTest
@testable import TDD_Swift

class TDD_SwiftTests: XCTestCase {

    func testMultiplication() {
        let five: Dollar = Dollar(amount: 5)
        var product: Dollar = five.times(multiplier: 2)
        XCTAssertEqual(10, product.amount)
        product = five.times(multiplier: 3)
        XCTAssertEqual(15, product.amount)
    }

    func testEquality() {
        XCTAssertTrue(Dollar(amount: 5) == Dollar(amount: 5))
        XCTAssertFalse(Dollar(amount: 5) == Dollar(amount: 6))
    }
}
```



# 第4章　意図を語るテスト

今章ではあまり詰まることがなく Swiftで実装することができました。

### TODOリスト
- $5 + 10CHF = $10（レートが2:1の場合）
- ~~$5 * 2 = $10~~
- amountをprivateにする
- ~~Dollarの副作用どうする？~~
- Moneyの丸め処理どうする？
- ~~equals()~~
- hashCode()
- nullとの等価性比較
- 他のオブジェクトとの等価性比較




``` Dollar.swift
import Foundation

class Dollar: Equatable {
    var amount: Int

    init(amount: Int) {
        self.amount = amount
    }

    func times(multiplier: Int) -> Dollar {
        return Dollar(amount: amount * multiplier)
    }

    static func == (lhs: Dollar, rhs: Dollar) -> Bool {
        lhs.amount == rhs.amount
    }
}
```


``` TDD_SwiftTests.swift
import XCTest
@testable import TDD_Swift

class TDD_SwiftTests: XCTestCase {

    func testMultiplication() {
        let five: Dollar = Dollar(amount: 5)
        XCTAssertEqual(Dollar(amount: 10), five.times(multiplier: 2))
        XCTAssertEqual(Dollar(amount: 15), five.times(multiplier: 3))
    }

    func testEquality() {
        XCTAssertTrue(Dollar(amount: 5) == Dollar(amount: 5))
        XCTAssertFalse(Dollar(amount: 5) == Dollar(amount: 6))
    }
}
```



# 第5章　原則をあえて破るとき

今章ではあまり詰まることがなく Swiftで実装することができました。

### TODOリスト
- $5 + 10CHF = $10（レートが2:1の場合）
- ~~$5 * 2 = $10~~
- ~~amountをprivateにする~~
- ~~Dollarの副作用どうする？~~
- Moneyの丸め処理どうする？
- ~~equals()~~
- hashCode()
- nullとの等価性比較
- 他のオブジェクトとの等価性比較
- 5 CHF * 2 = 10 CHF



``` Dollar.swift
import Foundation

class Dollar: Equatable {
    var amount: Int

    init(amount: Int) {
        self.amount = amount
    }

    func times(multiplier: Int) -> Dollar {
        return Dollar(amount: amount * multiplier)
    }

    static func == (lhs: Dollar, rhs: Dollar) -> Bool {
        lhs.amount == rhs.amount
    }
}
```

``` Franc.swift
import Foundation

class Franc: Equatable {
    var amount: Int

    init(amount: Int) {
        self.amount = amount
    }

    func times(multiplier: Int) -> Franc {
        return Franc(amount: amount * multiplier)
    }

    static func == (lhs: Franc, rhs: Franc) -> Bool {
        lhs.amount == rhs.amount
    }
}
```


``` TDD_SwiftTests.swift
import XCTest
@testable import TDD_Swift

class TDD_SwiftTests: XCTestCase {

    func testMultiplication() {
        let five: Dollar = Dollar(amount: 5)
        XCTAssertEqual(Dollar(amount: 10), five.times(multiplier: 2))
        XCTAssertEqual(Dollar(amount: 15), five.times(multiplier: 3))
    }

    func testFrancMultiplication() {
        let five: Franc = Franc(amount: 5)
        XCTAssertEqual(Franc(amount: 10), five.times(multiplier: 2))
        XCTAssertEqual(Franc(amount: 15), five.times(multiplier: 3))
    }

    func testEquality() {
        XCTAssertTrue(Dollar(amount: 5) == Dollar(amount: 5))
        XCTAssertFalse(Dollar(amount: 5) == Dollar(amount: 6))
    }
}
```






# 第6章　テスト不足に気づいたら

今章ではあまり詰まることがなく Swiftで実装することができました。

### TODOリスト
- $5 + 10CHF = $10（レートが2:1の場合）
- ~~$5 * 2 = $10~~
- ~~amountをprivateにする~~
- ~~Dollarの副作用どうする？~~
- Moneyの丸め処理どうする？
- ~~equals()~~
- hashCode()
- nullとの等価性比較
- 他のオブジェクトとの等価性比較
- 5 CHF * 2 = 10 CHF
- DollarとFrancの重複
- equalsの一般化
- timesの一般化


``` Money.swift
class Money: Equatable {
    let amount: Int

    init(amount: Int) {
        self.amount = amount
    }

    static func == (lhs: Money, rhs: Money) -> Bool {
        lhs.amount == rhs.amount
    }
}
```



``` Dollar.swift
class Dollar: Money {
    override init(amount: Int) {
        super.init(amount: amount)
    }

    func times(multiplier: Int) -> Dollar {
        return Dollar(amount: amount * multiplier)
    }
}
```

``` Franc.swift
class Franc: Money {

    override init(amount: Int) {
        super.init(amount: amount)
    }

    func times(multiplier: Int) -> Franc {
        return Franc(amount: amount * multiplier)
    }
}
```


``` TDD_SwiftTests.swift
import XCTest
@testable import TDD_Swift

class TDD_SwiftTests: XCTestCase {

    func testMultiplication() {
        let five: Dollar = Dollar(amount: 5)
        XCTAssertEqual(Dollar(amount: 10), five.times(multiplier: 2))
        XCTAssertEqual(Dollar(amount: 15), five.times(multiplier: 3))
    }

    func testFrancMultiplication() {
        let five: Franc = Franc(amount: 5)
        XCTAssertEqual(Franc(amount: 10), five.times(multiplier: 2))
        XCTAssertEqual(Franc(amount: 15), five.times(multiplier: 3))
    }

    func testEquality() {
        XCTAssertTrue(Dollar(amount: 5) == Dollar(amount: 5))
        XCTAssertFalse(Dollar(amount: 5) == Dollar(amount: 6))
        XCTAssertTrue(Franc(amount: 5) == Franc(amount: 5))
        XCTAssertFalse(Franc(amount: 5) == Franc(amount: 6))
    }
}
```



# 第7章　疑念をテストに翻訳する

7章ではフランが登場しました。
Java の実装では `instanceOf` メソッドで型の比較をしていますが、Swift の実装では `type(of: XXX)` メソッドを使用することで比較しました。

### TODOリスト
- $5 + 10CHF = $10（レートが2:1の場合）
- ~~$5 * 2 = $10~~
- ~~amountをprivateにする~~
- ~~Dollarの副作用どうする？~~
- Moneyの丸め処理どうする？
- ~~equals()~~
- hashCode()
- nullとの等価性比較
- 他のオブジェクトとの等価性比較
- 5 CHF * 2 = 10 CHF
- DollarとFrancの重複
- equalsの一般化
- timesの一般化
- FrancとDollarを比較する


``` Money.swift
class Money: Equatable {
    let amount: Int

    init(amount: Int) {
        self.amount = amount
    }

    static func == (lhs: Money, rhs: Money) -> Bool {
        return lhs.amount == rhs.amount && String(describing: type(of: lhs)) == String(describing: type(of: rhs))
    }
}
```



``` Dollar.swift
class Dollar: Money {
    override init(amount: Int) {
        super.init(amount: amount)
    }

    func times(multiplier: Int) -> Dollar {
        return Dollar(amount: amount * multiplier)
    }
}
```

``` Franc.swift
class Franc: Money {

    override init(amount: Int) {
        super.init(amount: amount)
    }

    func times(multiplier: Int) -> Franc {
        return Franc(amount: amount * multiplier)
    }
}
```


``` TDD_SwiftTests.swift
import XCTest
@testable import TDD_Swift

class TDD_SwiftTests: XCTestCase {

    func testMultiplication() {
        let five: Dollar = Dollar(amount: 5)
        XCTAssertEqual(Dollar(amount: 10), five.times(multiplier: 2))
        XCTAssertEqual(Dollar(amount: 15), five.times(multiplier: 3))
    }

    func testFrancMultiplication() {
        let five: Franc = Franc(amount: 5)
        XCTAssertEqual(Franc(amount: 10), five.times(multiplier: 2))
        XCTAssertEqual(Franc(amount: 15), five.times(multiplier: 3))
    }

    func testEquality() {
        XCTAssertTrue(Dollar(amount: 5) == Dollar(amount: 5))
        XCTAssertFalse(Dollar(amount: 5) == Dollar(amount: 6))
        XCTAssertTrue(Franc(amount: 5) == Franc(amount: 5))
        XCTAssertFalse(Franc(amount: 5) == Franc(amount: 6))
        XCTAssertFalse(Franc(amount: 5) == Dollar(amount: 5))
    }
}
```





# 第8章　実装を隠す

今回は少し困りました。
Java の実装で abstract クラスが登場したためです。
Swift には Abstract クラスに相当するものが無いため、 `Money` クラスを具象クラスとして定義してしまいました。
もしもっと良い書き方があればコメントいただきたいです。。。！

### TODOリスト
- $5 + 10CHF = $10（レートが2:1の場合）
- ~~$5 * 2 = $10~~
- ~~amountをprivateにする~~
- ~~Dollarの副作用どうする？~~
- Moneyの丸め処理どうする？
- ~~equals()~~
- hashCode()
- nullとの等価性比較
- 他のオブジェクトとの等価性比較
- ~~5 CHF * 2 = 10 CHF~~
- DollarとFrancの重複
- ~~equalsの一般化~~
- timesの一般化
- ~~FrancとDollarを比較する~~
- 通過の概念



``` Money.swift
class Money: Equatable {
    let amount: Int

    init(amount: Int) {
        self.amount = amount
    }

    static func == (lhs: Money, rhs: Money) -> Bool {
        return lhs.amount == rhs.amount && String(describing: type(of: lhs)) == String(describing: type(of: rhs))
    }

    static func dollar(amount: Int) -> Money {
        return Dollar(amount: amount)
    }

    static func franc(amount: Int) -> Money {
        return Franc(amount: amount)
    }

    func times(multiplier: Int) -> Money {
        fatalError()
    }
}
```



``` Dollar.swift
class Dollar: Money {
    override init(amount: Int) {
        super.init(amount: amount)
    }

    override func times(multiplier: Int) -> Money {
        return Dollar(amount: amount * multiplier)
    }
}
```

``` Franc.swift
class Franc: Money {

    override init(amount: Int) {
        super.init(amount: amount)
    }

    override func times(multiplier: Int) -> Money {
        return Franc(amount: amount * multiplier)
    }
}
```


``` TDD_SwiftTests.swift
import XCTest
@testable import TDD_Swift

class TDD_SwiftTests: XCTestCase {

    func testMultiplication() {
        let five: Money = Money.dollar(amount: 5)
        XCTAssertEqual(Money.dollar(amount: 10), five.times(multiplier: 2))
        XCTAssertEqual(Money.dollar(amount: 15), five.times(multiplier: 3))
    }

    func testFrancMultiplication() {
        let five: Money = Money.franc(amount: 5)
        XCTAssertEqual(Money.franc(amount: 10), five.times(multiplier: 2))
        XCTAssertEqual(Money.franc(amount: 15), five.times(multiplier: 3))
    }

    func testEquality() {
        XCTAssertTrue(Money.dollar(amount: 5) == Money.dollar(amount: 5))
        XCTAssertFalse(Money.dollar(amount: 5) == Money.dollar(amount: 6))
        XCTAssertTrue(Money.franc(amount: 5) == Money.franc(amount: 5))
        XCTAssertFalse(Money.franc(amount: 5) == Money.franc(amount: 6))
        XCTAssertFalse(Money.franc(amount: 5) == Money.dollar(amount: 5))
    }
}
```





# 第9章　歩幅の調整

今回はあまり詰まらず実装できました。

### TODOリスト
- $5 + 10CHF = $10（レートが2:1の場合）
- ~~$5 * 2 = $10~~
- ~~amountをprivateにする~~
- ~~Dollarの副作用どうする？~~
- Moneyの丸め処理どうする？
- ~~equals()~~
- hashCode()
- nullとの等価性比較
- 他のオブジェクトとの等価性比較
- ~~5 CHF * 2 = 10 CHF~~
- DollarとFrancの重複
- ~~equalsの一般化~~
- timesの一般化
- ~~FrancとDollarを比較する~~
- 通過の概念
- testFrancMultiplicationを削除する


``` Money.swift
class Money: Equatable {
    let amount: Int
    let currency: String

    init(amount: Int, currency: String) {
        self.amount = amount
        self.currency = currency
    }

    static func == (lhs: Money, rhs: Money) -> Bool {
        return lhs.amount == rhs.amount && String(describing: type(of: lhs)) == String(describing: type(of: rhs))
    }

    static func dollar(amount: Int) -> Money {
        return Dollar(amount: amount, currency: "USD")
    }

    static func franc(amount: Int) -> Money {
        return Franc(amount: amount, currency: "CHF")
    }

    func times(multiplier: Int) -> Money {
        fatalError("Must be overridden")
    }
}
```


``` Dollar.swift
class Dollar: Money {
    override init(amount: Int, currency: String) {
        super.init(amount: amount, currency: currency)
    }

    override func times(multiplier: Int) -> Money {
        return Money.dollar(amount: amount * multiplier)
    }
}
```

``` Franc.swift
class Franc: Money {
    override init(amount: Int, currency: String) {
        super.init(amount: amount, currency: currency)
    }

    override func times(multiplier: Int) -> Money {
        return Money.franc(amount: amount * multiplier)
    }
}
```


``` TDD_SwiftTests.swift
import XCTest
@testable import TDD_Swift

class TDD_SwiftTests: XCTestCase {
    func testMultiplication() {
        let five: Money = Money.dollar(amount: 5)
        XCTAssertEqual(Money.dollar(amount: 10), five.times(multiplier: 2))
        XCTAssertEqual(Money.dollar(amount: 15), five.times(multiplier: 3))
    }

    func testFrancMultiplication() {
        let five: Money = Money.franc(amount: 5)
        XCTAssertEqual(Money.franc(amount: 10), five.times(multiplier: 2))
        XCTAssertEqual(Money.franc(amount: 15), five.times(multiplier: 3))
    }

    func testEquality() {
        XCTAssertTrue(Money.dollar(amount: 5) == Money.dollar(amount: 5))
        XCTAssertFalse(Money.dollar(amount: 5) == Money.dollar(amount: 6))
        XCTAssertTrue(Money.franc(amount: 5) == Money.franc(amount: 5))
        XCTAssertFalse(Money.franc(amount: 5) == Money.franc(amount: 6))
        XCTAssertFalse(Money.franc(amount: 5) == Money.dollar(amount: 5))
    }

    func testCurrency() {
        XCTAssertEqual("USD", Money.dollar(amount: 1).currency)
        XCTAssertEqual("CHF", Money.franc(amount: 1).currency)
    }
}
```



# 第10章　テストに聞いてみる

Java だと `toString` メソッドでなんとかします。
Swift でそれに相当するものは `CustomStringConvertible` プロトコルに準拠し、`description` だと思ったので実装しました。

### TODOリスト
- $5 + 10CHF = $10（レートが2:1の場合）
- ~~$5 * 2 = $10~~
- ~~amountをprivateにする~~
- ~~Dollarの副作用どうする？~~
- Moneyの丸め処理どうする？
- ~~equals()~~
- hashCode()
- nullとの等価性比較
- 他のオブジェクトとの等価性比較
- ~~5 CHF * 2 = 10 CHF~~
- DollarとFrancの重複
- ~~equalsの一般化~~
- timesの一般化
- ~~FrancとDollarを比較する~~
- 通過の概念
- testFrancMultiplicationを削除する


``` Money.swift
class Money: Equatable, CustomStringConvertible {
    let amount: Int
    let currency: String

    init(amount: Int, currency: String) {
        self.amount = amount
        self.currency = currency
    }

    var description: String {
        return "\(amount) \(currency.description))"
    }

    static func == (lhs: Money, rhs: Money) -> Bool {
        return lhs.amount == rhs.amount && lhs.currency == rhs.currency
    }

    static func dollar(amount: Int) -> Money {
        return Dollar(amount: amount, currency: "USD")
    }

    static func franc(amount: Int) -> Money {
        return Franc(amount: amount, currency: "CHF")
    }

    func times(multiplier: Int) -> Money {
        return Money(amount: amount * multiplier, currency: currency)
    }
}
```



``` Dollar.swift
class Dollar: Money {
    override init(amount: Int, currency: String) {
        super.init(amount: amount, currency: currency)
    }
}
```

``` Franc.swift
class Franc: Money {
    override init(amount: Int, currency: String) {
        super.init(amount: amount, currency: currency)
    }
}
```


``` TDD_SwiftTests.swift
import XCTest
@testable import TDD_Swift

class TDD_SwiftTests: XCTestCase {
    func testMultiplication() {
        let five: Money = Money.dollar(amount: 5)
        XCTAssertEqual(Money.dollar(amount: 10), five.times(multiplier: 2))
        XCTAssertEqual(Money.dollar(amount: 15), five.times(multiplier: 3))
    }

    func testFrancMultiplication() {
        let five: Money = Money.franc(amount: 5)
        XCTAssertEqual(Money.franc(amount: 10), five.times(multiplier: 2))
        XCTAssertEqual(Money.franc(amount: 15), five.times(multiplier: 3))
    }

    func testEquality() {
        XCTAssertTrue(Money.dollar(amount: 5) == Money.dollar(amount: 5))
        XCTAssertFalse(Money.dollar(amount: 5) == Money.dollar(amount: 6))
        XCTAssertTrue(Money.franc(amount: 5) == Money.franc(amount: 5))
        XCTAssertFalse(Money.franc(amount: 5) == Money.franc(amount: 6))
        XCTAssertFalse(Money.franc(amount: 5) == Money.dollar(amount: 5))
    }

    func testCurrency() {
        XCTAssertEqual("USD", Money.dollar(amount: 1).currency)
        XCTAssertEqual("CHF", Money.franc(amount: 1).currency)
    }

    func testDifferentClassEquality() {
        XCTAssertTrue(Money(amount: 10, currency: "CHF") == Franc(amount: 10, currency: "CHF"))
    }
}
```








# 第11章　不要になったら消す

今回はあまり困らず実装することができました。

### TODOリスト
- $5 + 10CHF = $10（レートが2:1の場合）
- ~~$5 * 2 = $10~~
- ~~amountをprivateにする~~
- ~~Dollarの副作用どうする？~~
- Moneyの丸め処理どうする？
- ~~equals()~~
- hashCode()
- nullとの等価性比較
- 他のオブジェクトとの等価性比較
- ~~5 CHF * 2 = 10 CHF~~
- DollarとFrancの重複
- ~~equalsの一般化~~
- timesの一般化
- ~~FrancとDollarを比較する~~
- 通過の概念
- testFrancMultiplicationを削除する


``` Money.swift
class Money: Equatable, CustomStringConvertible {
    let amount: Int
    let currency: String

    init(amount: Int, currency: String) {
        self.amount = amount
        self.currency = currency
    }

    var description: String {
        return "\(amount) \(currency.description))"
    }

    static func == (lhs: Money, rhs: Money) -> Bool {
        return lhs.amount == rhs.amount && lhs.currency == rhs.currency
    }

    static func dollar(amount: Int) -> Money {
        return Money(amount: amount, currency: "USD")
    }

    static func franc(amount: Int) -> Money {
        return Money(amount: amount, currency: "CHF")
    }

    func times(multiplier: Int) -> Money {
        return Money(amount: amount * multiplier, currency: currency)
    }
}
```


``` TDD_SwiftTests.swift
import XCTest
@testable import TDD_Swift

class TDD_SwiftTests: XCTestCase {
    func testMultiplication() {
        let five: Money = Money.dollar(amount: 5)
        XCTAssertEqual(Money.dollar(amount: 10), five.times(multiplier: 2))
        XCTAssertEqual(Money.dollar(amount: 15), five.times(multiplier: 3))
    }

    func testEquality() {
        XCTAssertTrue(Money.dollar(amount: 5) == Money.dollar(amount: 5))
        XCTAssertFalse(Money.dollar(amount: 5) == Money.dollar(amount: 6))
        XCTAssertFalse(Money.franc(amount: 5) == Money.dollar(amount: 5))
    }

    func testCurrency() {
        XCTAssertEqual("USD", Money.dollar(amount: 1).currency)
        XCTAssertEqual("CHF", Money.franc(amount: 1).currency)
    }
}
```




# 第12章　設計とメタファー

あまり困らず実装できました。

### TODOリスト
- $5 + 10CHF = $10（レートが2:1の場合）
- $5 + $5 = $10





``` Money.swift
class Money: Equatable, CustomStringConvertible, Expression {
    let amount: Int
    let currency: String

    init(amount: Int, currency: String) {
        self.amount = amount
        self.currency = currency
    }

    var description: String {
        return "\(amount) \(currency.description))"
    }

    static func == (lhs: Money, rhs: Money) -> Bool {
        return lhs.amount == rhs.amount && lhs.currency == rhs.currency
    }

    static func dollar(amount: Int) -> Money {
        return Money(amount: amount, currency: "USD")
    }

    static func franc(amount: Int) -> Money {
        return Money(amount: amount, currency: "CHF")
    }

    func times(multiplier: Int) -> Money {
        return Money(amount: amount * multiplier, currency: currency)
    }

    func plus(addend: Money) -> Expression {
        return Money(amount: amount + addend.amount, currency: currency)
    }
}
```

``` Expression.swift
protocol Expression {
}
```

``` Bank.swift
class Bank {
    func reduce(source: Expression, to: String) -> Money {
        return Money.dollar(amount: 10)
    }
}
```

``` TDD_SwiftTests.swift
import XCTest
@testable import TDD_Swift

class TDD_SwiftTests: XCTestCase {
    func testMultiplication() {
        let five: Money = Money.dollar(amount: 5)
        XCTAssertEqual(Money.dollar(amount: 10), five.times(multiplier: 2))
        XCTAssertEqual(Money.dollar(amount: 15), five.times(multiplier: 3))
    }

    func testEquality() {
        XCTAssertTrue(Money.dollar(amount: 5) == Money.dollar(amount: 5))
        XCTAssertFalse(Money.dollar(amount: 5) == Money.dollar(amount: 6))
        XCTAssertFalse(Money.franc(amount: 5) == Money.dollar(amount: 5))
    }

    func testCurrency() {
        XCTAssertEqual("USD", Money.dollar(amount: 1).currency)
        XCTAssertEqual("CHF", Money.franc(amount: 1).currency)
    }
}
```


# 第13章　実装を導くテスト

型のキャストがあります。
Swift は `if let` 構文でいい感じにできるので、いい感じにできます。

```
if let money = source as? Money {
    return money
}
```


### TODOリスト
- $5 + 10CHF = $10（レートが2:1の場合）
- $5 + $5 = $10


``` Money.swift
class Money: Equatable, CustomStringConvertible, Expression {
    let amount: Int
    let currency: String

    init(amount: Int, currency: String) {
        self.amount = amount
        self.currency = currency
    }

    var description: String {
        return "\(amount) \(currency.description))"
    }

    static func == (lhs: Money, rhs: Money) -> Bool {
        return lhs.amount == rhs.amount && lhs.currency == rhs.currency
    }

    static func dollar(amount: Int) -> Money {
        return Money(amount: amount, currency: "USD")
    }

    static func franc(amount: Int) -> Money {
        return Money(amount: amount, currency: "CHF")
    }

    func times(multiplier: Int) -> Money {
        return Money(amount: amount * multiplier, currency: currency)
    }

    func plus(addend: Money) -> Expression {
        return Sum(augend: self, addend: addend)
    }

    func reduce(to: String)-> Money {
        return self
    }
}
```

``` Sum.swift
class Sum: Expression {
    let augend: Money
    let addend: Money

    init(augend: Money, addend: Money) {
        self.augend = augend
        self.addend = addend
    }

    func reduce(to: String) -> Money {
        let amount: Int = augend.amount + addend.amount
        return Money(amount: amount, currency: to)
    }
}
```

``` Expression.swift
protocol Expression {
    func reduce(to: String) -> Money
}
```

``` Bank.swift
class Bank {
    func reduce(source: Expression, to: String) -> Money {
        return source.reduce(to: to)
    }
}
```

``` TDD_SwiftTests.swift
import XCTest
@testable import TDD_Swift

class TDD_SwiftTests: XCTestCase {
    func testMultiplication() {
        let five: Money = Money.dollar(amount: 5)
        XCTAssertEqual(Money.dollar(amount: 10), five.times(multiplier: 2))
        XCTAssertEqual(Money.dollar(amount: 15), five.times(multiplier: 3))
    }

    func testEquality() {
        XCTAssertTrue(Money.dollar(amount: 5) == Money.dollar(amount: 5))
        XCTAssertFalse(Money.dollar(amount: 5) == Money.dollar(amount: 6))
        XCTAssertFalse(Money.franc(amount: 5) == Money.dollar(amount: 5))
    }

    func testCurrency() {
        XCTAssertEqual("USD", Money.dollar(amount: 1).currency)
        XCTAssertEqual("CHF", Money.franc(amount: 1).currency)
    }

    func testSimpleAddition() {
        let five: Money = Money.dollar(amount: 5)
        let sum: Expression = five.plus(addend: five)
        let bank: Bank = Bank()
        let reduced: Money = bank.reduce(source: sum, to: "USD")
        XCTAssertEqual(Money.dollar(amount: 10), reduced)
    }

    func testPlusReturnSum() {
        let five: Money = Money.dollar(amount: 5)
        let result: Expression = five.plus(addend: five)
        let sum: Sum = result as! Sum
        XCTAssertEqual(five, sum.addend)
    }

    func testResuceSum() {
        let sum: Expression = Sum(augend: Money.dollar(amount: 3), addend: Money.dollar(amount: 4))
        let bank: Bank = Bank()
        let result: Money = bank.reduce(source: sum, to: "USD")
        XCTAssertEqual(Money.dollar(amount: 7), result)
    }

    func testReduceMoney() {
        let bank: Bank = Bank()
        let result: Money = bank.reduce(source: Money.dollar(amount: 1), to: "USD")
        XCTAssertEqual(Money.dollar(amount: 1), result)
    }
}
```








# 第14章　学習用テストと回帰テスト

ここもあまり困らず実装することができました。

### TODOリスト
- $5 + 10CHF = $10（レートが2:1の場合）
- $5 + $5 = $10




``` Money.swift
class Money: Equatable, CustomStringConvertible, Expression {
    let amount: Int
    let currency: String

    init(amount: Int, currency: String) {
        self.amount = amount
        self.currency = currency
    }

    var description: String {
        return "\(amount) \(currency.description))"
    }

    static func == (lhs: Money, rhs: Money) -> Bool {
        return lhs.amount == rhs.amount && lhs.currency == rhs.currency
    }

    static func dollar(amount: Int) -> Money {
        return Money(amount: amount, currency: "USD")
    }

    static func franc(amount: Int) -> Money {
        return Money(amount: amount, currency: "CHF")
    }

    func times(multiplier: Int) -> Money {
        return Money(amount: amount * multiplier, currency: currency)
    }

    func plus(addend: Money) -> Expression {
        return Sum(augend: self, addend: addend)
    }

    func reduce(bank: Bank, to: String)-> Money {
        let rate: Int = bank.rate(from: currency, to: to)
        return Money(amount: amount / rate, currency: to)
    }
}
```

``` Sum.swift
class Sum: Expression {
    let augend: Money
    let addend: Money

    init(augend: Money, addend: Money) {
        self.augend = augend
        self.addend = addend
    }

    func reduce(bank:Bank, to: String) -> Money {
        let amount: Int = augend.amount + addend.amount
        return Money(amount: amount, currency: to)
    }
}
```

``` Expression.swift
protocol Expression {
    func reduce(bank: Bank, to: String) -> Money
}
```

``` Bank.swift
class Bank {
    private var rates: [Pair: Int] = [:]

    func reduce(source: Expression, to: String) -> Money {
        return source.reduce(bank: self, to: to)
    }

    func addRate(from: String, to: String, rate: Int) {
        rates[Pair(from: from, to: to)] = rate
    }

    func rate(from: String, to: String) -> Int {
        if from == to {
            return 1
        }

        guard let rate = rates[Pair(from: from, to: to)] else {
            fatalError("未対応の通過です")
        }
        return rate
    }
}
```

```Pair.swift
class Pair: Hashable {
    private let from: String
    private let to: String

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
```


``` TDD_SwiftTests.swift
import XCTest
@testable import TDD_Swift

class TDD_SwiftTests: XCTestCase {
    func testMultiplication() {
        let five: Money = Money.dollar(amount: 5)
        XCTAssertEqual(Money.dollar(amount: 10), five.times(multiplier: 2))
        XCTAssertEqual(Money.dollar(amount: 15), five.times(multiplier: 3))
    }

    func testEquality() {
        XCTAssertTrue(Money.dollar(amount: 5) == Money.dollar(amount: 5))
        XCTAssertFalse(Money.dollar(amount: 5) == Money.dollar(amount: 6))
        XCTAssertFalse(Money.franc(amount: 5) == Money.dollar(amount: 5))
    }

    func testCurrency() {
        XCTAssertEqual("USD", Money.dollar(amount: 1).currency)
        XCTAssertEqual("CHF", Money.franc(amount: 1).currency)
    }

    func testSimpleAddition() {
        let five: Money = Money.dollar(amount: 5)
        let sum: Expression = five.plus(addend: five)
        let bank: Bank = Bank()
        let reduced: Money = bank.reduce(source: sum, to: "USD")
        XCTAssertEqual(Money.dollar(amount: 10), reduced)
    }

    func testPlusReturnSum() {
        let five: Money = Money.dollar(amount: 5)
        let result: Expression = five.plus(addend: five)
        let sum: Sum = result as! Sum
        XCTAssertEqual(five, sum.addend)
    }

    func testResuceSum() {
        let sum: Expression = Sum(augend: Money.dollar(amount: 3), addend: Money.dollar(amount: 4))
        let bank: Bank = Bank()
        let result: Money = bank.reduce(source: sum, to: "USD")
        XCTAssertEqual(Money.dollar(amount: 7), result)
    }

    func testReduceMoney() {
        let bank: Bank = Bank()
        let result: Money = bank.reduce(source: Money.dollar(amount: 1), to: "USD")
        XCTAssertEqual(Money.dollar(amount: 1), result)
    }

    func testReduceMoneyDifferentCurrency() {
        let bank: Bank = Bank()
        bank.addRate(from: "CHF", to: "USD", rate: 2)
        let result: Money = bank.reduce(source: Money.franc(amount: 2), to: "USD")
        XCTAssertEqual(Money.dollar(amount: 1), result)
    }

    func testIdentityRate() {
        XCTAssertEqual(1, Bank().rate(from: "USD", to: "USD"))
    }
}
```






# 第15章　テスト任せとコンパイラ任せ

Java の実装を参考にしながら Swift で実装したところ、 `Protocol type 'Expression' cannot conform to 'Equatable' because only concrete types can conform to protocols` って怒られました。
Swift だと `protcol` 同士の比較ができないそうなので、仕方なくこんな感じで書きました。

### TODOリスト
- $5 + 10CHF = $10（レートが2:1の場合）
- $5 + $5 = $10
- $5 + $5 = $10がMoneyを返す
- Bank.reduce(Money)
- Moneyを変換して換算を行う
- Reduce(Bank, String)


``` Money.swift
class Money: Equatable, CustomStringConvertible, Expression {
    let amount: Int
    let currency: String

    init(amount: Int, currency: String) {
        self.amount = amount
        self.currency = currency
    }

    var description: String {
        return "\(amount) \(currency.description))"
    }

    static func == (lhs: Money, rhs: Money) -> Bool {
        return lhs.amount == rhs.amount && lhs.currency == rhs.currency
    }

    static func dollar(amount: Int) -> Money {
        return Money(amount: amount, currency: "USD")
    }

    static func franc(amount: Int) -> Money {
        return Money(amount: amount, currency: "CHF")
    }

    func times(multiplier: Int) -> Expression {
        return Money(amount: amount * multiplier, currency: currency)
    }

    func plus(addend: Expression) -> Expression {
        return Sum(augend: self, addend: addend)
    }

    func reduce(bank: Bank, to: String)-> Money {
        let rate: Int = bank.rate(from: currency, to: to)
        return Money(amount: amount / rate, currency: to)
    }
}
```

``` Sum.swift
class Sum: Expression {
    let augend: Expression
    let addend: Expression

    init(augend: Expression, addend: Expression) {
        self.augend = augend
        self.addend = addend
    }

    func plus(addend: Expression) -> Expression {
        fatalError()
    }

    func reduce(bank: Bank, to: String) -> Money {
        let amount: Int = augend.reduce(bank: bank, to: to).amount + addend.reduce(bank: bank, to: to).amount
        return Money(amount: amount, currency: to)
    }
}
```

``` Expression.swift
protocol Expression {
    func plus(addend: Expression) -> Expression
    func reduce(bank: Bank, to: String) -> Money
}
```

``` Bank.swift
class Bank {
    private var rates: [Pair: Int] = [:]

    func reduce(source: Expression, to: String) -> Money {
        return source.reduce(bank: self, to: to)
    }

    func addRate(from: String, to: String, rate: Int) {
        rates[Pair(from: from, to: to)] = rate
    }

    func rate(from: String, to: String) -> Int {
        if from == to {
            return 1
        }

        guard let rate = rates[Pair(from: from, to: to)] else {
            fatalError("未対応の通過です")
        }
        return rate
    }
}
```

```Pair.swift
class Pair: Hashable {
    private let from: String
    private let to: String

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
```

``` TDD_SwiftTests.swift
import XCTest
@testable import TDD_Swift

class TDD_SwiftTests: XCTestCase {
    func testMultiplication() {
        let five: Money = Money.dollar(amount: 5)
        // XCTAssertEqual(Money.dollar(amount: 10), five.times(multiplier: 2))
        XCTAssertEqual(Money.dollar(amount: 10), five.times(multiplier: 2).reduce(bank: Bank(), to: "USD"))
        // XCTAssertEqual(Money.dollar(amount: 15), five.times(multiplier: 3))
        XCTAssertEqual(Money.dollar(amount: 15), five.times(multiplier: 3).reduce(bank: Bank(), to: "USD"))
    }

    func testEquality() {
        XCTAssertTrue(Money.dollar(amount: 5) == Money.dollar(amount: 5))
        XCTAssertFalse(Money.dollar(amount: 5) == Money.dollar(amount: 6))
        XCTAssertFalse(Money.franc(amount: 5) == Money.dollar(amount: 5))
    }

    func testCurrency() {
        XCTAssertEqual("USD", Money.dollar(amount: 1).currency)
        XCTAssertEqual("CHF", Money.franc(amount: 1).currency)
    }

    func testSimpleAddition() {
        let five: Money = Money.dollar(amount: 5)
        let sum: Expression = five.plus(addend: five)
        let bank: Bank = Bank()
        let reduced: Money = bank.reduce(source: sum, to: "USD")
        XCTAssertEqual(Money.dollar(amount: 10), reduced)
    }

    func testPlusReturnSum() {
        let five: Money = Money.dollar(amount: 5)
        let result: Expression = five.plus(addend: five)
        let sum: Sum = result as! Sum
        // XCTAssertEqual(five, sum.added)
        XCTAssertEqual(five, sum.addend.reduce(bank: Bank(), to: "USD"))
    }

    func testResuceSum() {
        let sum: Expression = Sum(augend: Money.dollar(amount: 3), addend: Money.dollar(amount: 4))
        let bank: Bank = Bank()
        let result: Money = bank.reduce(source: sum, to: "USD")
        XCTAssertEqual(Money.dollar(amount: 7), result)
    }

    func testReduceMoney() {
        let bank: Bank = Bank()
        let result: Money = bank.reduce(source: Money.dollar(amount: 1), to: "USD")
        XCTAssertEqual(Money.dollar(amount: 1), result)
    }

    func testReduceMoneyDifferentCurrency() {
        let bank: Bank = Bank()
        bank.addRate(from: "CHF", to: "USD", rate: 2)
        let result: Money = bank.reduce(source: Money.franc(amount: 2), to: "USD")
        XCTAssertEqual(Money.dollar(amount: 1), result)
    }

    func testIdentityRate() {
        XCTAssertEqual(1, Bank().rate(from: "USD", to: "USD"))
    }

    func testMixedAddition() {
        let fiveBucks: Expression = Money.dollar(amount: 5)
        let tenFrancs: Expression = Money.franc(amount: 10)
        let bank: Bank = Bank()
        bank.addRate(from: "CHF", to: "USD", rate: 2)
        let result: Money = bank.reduce(source: fiveBucks.plus(addend: tenFrancs), to: "USD")
        XCTAssertEqual(Money.dollar(amount: 10), result)
    }
}
```


# 第16章　将来の読み手を考えたテスト




### TODOリスト
- $5 + 10CHF = $10（レートが2:1の場合）
- ~~$5 + $5 = $10~~
- $5 + $5 = $10がMoneyを返す
- ~~Bank.reduce(Money)~~
- ~~Moneyを変換して換算を行う~~
- ~~Reduce(Bank, String)~~
- Sum.plus
- Expression.times




``` Money.swift
class Money: Equatable, CustomStringConvertible, Expression {
    let amount: Int
    let currency: String

    init(amount: Int, currency: String) {
        self.amount = amount
        self.currency = currency
    }

    var description: String {
        return "\(amount) \(currency.description))"
    }

    static func == (lhs: Money, rhs: Money) -> Bool {
        return lhs.amount == rhs.amount && lhs.currency == rhs.currency
    }

    static func dollar(amount: Int) -> Money {
        return Money(amount: amount, currency: "USD")
    }

    static func franc(amount: Int) -> Money {
        return Money(amount: amount, currency: "CHF")
    }

    func times(multiplier: Int) -> Expression {
        return Money(amount: amount * multiplier, currency: currency)
    }

    func plus(addend: Expression) -> Expression {
        return Sum(augend: self, addend: addend)
    }

    func reduce(bank: Bank, to: String)-> Money {
        let rate: Int = bank.rate(from: currency, to: to)
        return Money(amount: amount / rate, currency: to)
    }
}
```

``` Sum.swift
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
```

``` Expression.swift
protocol Expression {
    func times(multiplier: Int) -> Expression
    func plus(addend: Expression) -> Expression
    func reduce(bank: Bank, to: String) -> Money
}
```

``` Bank.swift
class Bank {
    private var rates: [Pair: Int] = [:]

    func reduce(source: Expression, to: String) -> Money {
        return source.reduce(bank: self, to: to)
    }

    func addRate(from: String, to: String, rate: Int) {
        rates[Pair(from: from, to: to)] = rate
    }

    func rate(from: String, to: String) -> Int {
        if from == to {
            return 1
        }

        guard let rate = rates[Pair(from: from, to: to)] else {
            fatalError("未対応の通過です")
        }
        return rate
    }
}
```

```Pair.swift
class Pair: Hashable {
    private let from: String
    private let to: String

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
```


``` TDD_SwiftTests.swift
import XCTest
@testable import TDD_Swift

class TDD_SwiftTests: XCTestCase {
    func testMultiplication() {
        let five: Money = Money.dollar(amount: 5)
        // XCTAssertEqual(Money.dollar(amount: 10), five.times(multiplier: 2))
        XCTAssertEqual(Money.dollar(amount: 10), five.times(multiplier: 2).reduce(bank: Bank(), to: "USD"))
        // XCTAssertEqual(Money.dollar(amount: 15), five.times(multiplier: 3))
        XCTAssertEqual(Money.dollar(amount: 15), five.times(multiplier: 3).reduce(bank: Bank(), to: "USD"))
    }

    func testEquality() {
        XCTAssertTrue(Money.dollar(amount: 5) == Money.dollar(amount: 5))
        XCTAssertFalse(Money.dollar(amount: 5) == Money.dollar(amount: 6))
        XCTAssertFalse(Money.franc(amount: 5) == Money.dollar(amount: 5))
    }

    func testCurrency() {
        XCTAssertEqual("USD", Money.dollar(amount: 1).currency)
        XCTAssertEqual("CHF", Money.franc(amount: 1).currency)
    }

    func testSimpleAddition() {
        let five: Money = Money.dollar(amount: 5)
        let sum: Expression = five.plus(addend: five)
        let bank: Bank = Bank()
        let reduced: Money = bank.reduce(source: sum, to: "USD")
        XCTAssertEqual(Money.dollar(amount: 10), reduced)
    }

    func testPlusReturnSum() {
        let five: Money = Money.dollar(amount: 5)
        let result: Expression = five.plus(addend: five)
        let sum: Sum = result as! Sum
        // XCTAssertEqual(five, sum.added)
        XCTAssertEqual(five, sum.addend.reduce(bank: Bank(), to: "USD"))
    }

    func testResuceSum() {
        let sum: Expression = Sum(augend: Money.dollar(amount: 3), addend: Money.dollar(amount: 4))
        let bank: Bank = Bank()
        let result: Money = bank.reduce(source: sum, to: "USD")
        XCTAssertEqual(Money.dollar(amount: 7), result)
    }

    func testReduceMoney() {
        let bank: Bank = Bank()
        let result: Money = bank.reduce(source: Money.dollar(amount: 1), to: "USD")
        XCTAssertEqual(Money.dollar(amount: 1), result)
    }

    func testReduceMoneyDifferentCurrency() {
        let bank: Bank = Bank()
        bank.addRate(from: "CHF", to: "USD", rate: 2)
        let result: Money = bank.reduce(source: Money.franc(amount: 2), to: "USD")
        XCTAssertEqual(Money.dollar(amount: 1), result)
    }

    func testIdentityRate() {
        XCTAssertEqual(1, Bank().rate(from: "USD", to: "USD"))
    }

    func testMixedAddition() {
        let fiveBucks: Expression = Money.dollar(amount: 5)
        let tenFrancs: Expression = Money.franc(amount: 10)
        let bank: Bank = Bank()
        bank.addRate(from: "CHF", to: "USD", rate: 2)
        let result: Money = bank.reduce(source: fiveBucks.plus(addend: tenFrancs), to: "USD")
        XCTAssertEqual(Money.dollar(amount: 10), result)
    }

    func testSumPlusMoney() {
        let fiveBucks: Expression = Money.dollar(amount: 5)
        let tenFrancs: Expression = Money.franc(amount: 10)
        let bank: Bank = Bank()
        bank.addRate(from: "CHF", to: "USD", rate: 2)
        let sum: Expression = Sum(augend: fiveBucks, addend: tenFrancs).plus(addend: fiveBucks)
        let result = bank.reduce(source: sum, to: "USD")
        XCTAssertEqual(Money.dollar(amount: 15), result)
    }

    func testSumTimes() {
        let fiveBucks: Expression = Money.dollar(amount: 5)
        let tenFrancs: Expression = Money.franc(amount: 10)
        let bank: Bank = Bank()
        bank.addRate(from: "CHF", to: "USD", rate: 2)
        let sum: Expression = Sum(augend: fiveBucks, addend: tenFrancs).times(multiplier: 2)
        let result: Money = bank.reduce(source: sum, to: "USD")
        XCTAssertEqual(Money.dollar(amount: 20), result)
    }
}
```


# まとめ

TDD 楽しかったです。
すごく話しかけるようになんとかしてくれて、すごく勉強になりました。
皆さんの好きな言語で出来たらいいと思います。
そして Swift で実装しようとしている人の参考になれば嬉しいです。


# 参考
[テスト駆動開発](https://www.amazon.co.jp/%E3%83%86%E3%82%B9%E3%83%88%E9%A7%86%E5%8B%95%E9%96%8B%E7%99%BA-Kent-Beck/dp/4274217884)  
[関数型言語Elmでテスト駆動開発(第1~4章)](https://qiita.com/ababup1192/items/d6ca1af6efcbac8d550f)  
[関数型言語Elmでテスト駆動開発(第5~7章)](https://qiita.com/ababup1192/items/5b9d6293210b1b09015d)  
