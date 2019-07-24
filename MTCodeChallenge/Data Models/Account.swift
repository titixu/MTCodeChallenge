//  Copyright © 2019 Sam Xu. All rights reserved.
//

import Foundation

// assumptions: all json vales are not nil, except description from Transaction

struct AccountsJSONObject: Codable {
    let accounts: [Account]
}

struct Account: Codable {
    var id: Int
    var nickname: String
    var institution: String
    var currency: String
    var currentBalance: Double
    var currentBalanceInBase: Double
}

struct TransactionsJSONObject: Codable {
    let transactions: [Transaction]
}

struct Transaction: Codable {
    var accountId: Int
    var amount: Double
    var categoryId: Int
    var date: String
    var description: String?
    var id: Int
}
