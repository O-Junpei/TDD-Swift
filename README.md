#  Swift でテスト駆動開発をやってみた

弊社弊チームでは TDD を習得するために Kent Beck(著), 和田 卓人(翻訳)の [テスト駆動開発](https://www.amazon.co.jp/%E3%83%86%E3%82%B9%E3%83%88%E9%A7%86%E5%8B%95%E9%96%8B%E7%99%BA-Kent-Beck/dp/4274217884) の輪読をしています。  
[テスト駆動開発](https://www.amazon.co.jp/%E3%83%86%E3%82%B9%E3%83%88%E9%A7%86%E5%8B%95%E9%96%8B%E7%99%BA-Kent-Beck/dp/4274217884) はとても良い本で、「写経ではなく別の言語で挑戦することで、TDDをより深く習得したい」 & 「Swift自体の勉強がしたい」と思い、Swift でテスト駆動開発(TDD)に挑戦してみました。


## 方針と注意事項
本文の内容やコードは、著作権を考慮して極力載せず、Swift のコードとテストのTODOリストだけでやっていきたいと思っています。  
もし関係者の方々から注意喚起があれば即記事を削除する予定なので、ご了承ください。  
言語が異なるので進め方が多少異なる場合があります。  


## 事前準備
UnitTest を

まずはじめに、Elmのテストが動く環境を用意しましょう。今回は男らしくHtmlによる表示もビルドもできない本当にテストをするだけの環境を用意しました。みなさんがテスト実行に必要なのは、npm(Node.js環境)のみです。



# 第1章 仮実装


ものすごく大雑把に説明するとUSドルやフランを扱うことができる仮想通貨システムをTDDで作り上げていくことになります。最初の作るべき機能として、以下のTODOリストが挙げられます。もっとも簡単な機能としてドルの掛け算を実装していきます。

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


#



# 第2章 明白な実装

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

### TODOリスト
- $5 + 10CHF = $10（レートが2:1の場合）
- ~~$5 * 2 = $10~~
- amountをprivateにする
- Dollarの副作用どうする？
- Moneyの丸め処理どうする？
- equals()


Swift では比較するために `Equatable` プロトコルに準拠する必要がある。
実装しよう。

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


# 第6章　テスト不足に気づいたら


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



# 第7章　疑念をテストに翻訳する

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


# 第8章　実装を隠す

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



# 第9章　歩幅の調整

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



# 第10章　テストに聞いてみる


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


# 第11章　不要になったら消す


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


# 第12章　設計とメタファー


### TODOリスト
- $5 + 10CHF = $10（レートが2:1の場合）
- $5 + $5 = $10



# 第13章　実装を導くテスト

### TODOリスト
- $5 + 10CHF = $10（レートが2:1の場合）
- $5 + $5 = $10


# 第14章　学習用テストと回帰テスト

### TODOリスト
- $5 + 10CHF = $10（レートが2:1の場合）
- $5 + $5 = $10



# 第15章　テスト任せとコンパイラ任せ

### TODOリスト
- $5 + 10CHF = $10（レートが2:1の場合）
- $5 + $5 = $10
- $5 + $5 = $10がMoneyを返す
- Bank.reduce(Money)
- Moneyを変換して換算を行う
- Reduce(Bank, String)



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



# 第17章　多国通貨の全体ふりかえり


# まとめ


# 参考
[テスト駆動開発](https://www.amazon.co.jp/%E3%83%86%E3%82%B9%E3%83%88%E9%A7%86%E5%8B%95%E9%96%8B%E7%99%BA-Kent-Beck/dp/4274217884)  
[関数型言語Elmでテスト駆動開発(第1~4章)](https://qiita.com/ababup1192/items/d6ca1af6efcbac8d550f)  
[関数型言語Elmでテスト駆動開発(第5~7章)](https://qiita.com/ababup1192/items/5b9d6293210b1b09015d)  
