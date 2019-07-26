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

enum AccountType {
    case local
    case foreign
}

// Assuming default account type is JP
extension Account {
    var type: AccountType {
        if currency == "JPY" {
            return .local
        } else {
            return .foreign
        }
    }
}

struct TransactionsJSONObject: Codable {
    let transactions: [Transaction]
}

struct Transaction: Codable {
    var accountId: Int
    var amount: Double
    var categoryId: Int
    var date: Date
    var description: String?
    var id: Int
}
