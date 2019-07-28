//  Copyright © 2019 Sam Xu. All rights reserved.
//

import Foundation

// AccountViewModel that provide data into AccountViewController

struct AccountViewModel {
    var apiClient:APIClient
    var account: Account
    var transactionsGrouped: [[Transaction]] = []
    
    var onLoading: (AccountViewModel) -> Void
    var onComplete: (AccountViewModel) -> Void
    
    /**
     inti the function with
     */
    init(account: Account,
         apiClient: APIClient,
         onLoading: @escaping (AccountViewModel) -> Void,
         onComplete: @escaping (AccountViewModel) -> Void) {
        self.account = account
        self.apiClient = apiClient
        self.onLoading = onLoading
        self.onComplete = onComplete
    }
    
    mutating func fetchAccount() {
        onLoading(self)
        
        apiClient.loadTransactions(for: account.id) { (transactions) in
            // group the transaction date into month
            let groupedDictionary = Dictionary(grouping: transactions, by: { (transaction) -> String in
                // group by comparing the year and month string, for example "2017 09"
                return DateFormatter.yearMonth.string(from: transaction.date)
            })
            
            // desc sort the keys (year month) and extract values ([Transaction])
            let result = groupedDictionary.keys.sorted(by: { $0 > $1 })
                .map {
                    // desc sort the date before append it
                    return groupedDictionary[$0]!.sorted(by: {
                        $0.date > $1.date
                    })
            }
            self.transactionsGrouped = result
            
            onComplete(self)
        }
        
    }
    
}

// MARK: - Table View Data Source methods
extension AccountViewModel {
    
    func transaction(indexPath: IndexPath) -> Transaction {
        return transactionsGrouped[indexPath.section][indexPath.row]
    }
    
    func numberOfSections() -> Int {
        return transactionsGrouped.count
    }
    
    func numberOfRowsInSection(_ section: Int) -> Int {
        return transactionsGrouped[section].count
    }
    
    func transactionDayString(_ transaction: Transaction) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd"
        return formatter.string(from: transaction.date)
    }
    
    // Section headers methods
    func dayString(section: Int) -> String? {
        guard let transaction = transactionsGrouped[section].first  else {
            return nil
        }
        
        if transaction.date.isCurrentMonth {
            return "This Month"
        }
        
        return DateFormatter.monthYear.string(from: transaction.date)
    }
    
    func monthlyInString(section: Int) -> String? {
        let transactions = transactionsGrouped[section]
        let totalInAmount = inAmount(transactions: transactions)
        if totalInAmount == 0.0 {
            // this will hide the label in the section header
            return nil
        }
        // there are empty space in the prefix and posfix of the string
        // it is a hack to make sure the text is not out of bounce from it's rounded background
        return "  \(account.currencyString(amount: totalInAmount))  "
    }
    
    func monthlyOutString(section: Int) -> String? {
        let transactions = transactionsGrouped[section]
        let totalOutAmount = outAmount(transactions: transactions)
        if totalOutAmount == 0.0 {
            return nil
        }
        return "  \(account.currencyString(amount: totalOutAmount))  "
    }
    // END Section headers methods
}


// MARK: - Table header View Data source methods
extension AccountViewModel {
    
    // get the first transaction group that has transaction in the current month
    var currentMonthTransactions: [Transaction]? {
        let transactionsInCurrentMonth = transactionsGrouped.first { (transactions) -> Bool in
            if let transaction = transactions.first {
                return transaction.date.isCurrentMonth
            }
            return false
            
        }
        
        return transactionsInCurrentMonth
    }
    
    func inAmount(transactions: [Transaction]) -> Double {
        // sum of all transactions has positive amount
        return transactions.filter { (transaction) -> Bool in
            transaction.amount > 0.0
            }.reduce(0.0) { (result, transaction) -> Double in
                result + transaction.amount
        }
    }
    
    func outAmount(transactions: [Transaction]) -> Double {
        // sum of all transactions has negative amount
        return transactions.filter { (transaction) -> Bool in
            transaction.amount < 0.0
            }.reduce(0.0) { (result, transaction) -> Double in
                result + transaction.amount
        }
    }
    
    var headerViewModel: AccountHeaderViewModel {
        var monthIn = 0.0
        var monthOut = 0.0
        
        if let currentMonth = currentMonthTransactions {
            monthIn = inAmount(transactions: currentMonth)
            monthOut = outAmount(transactions: currentMonth)
        }
        
        return AccountHeaderViewModel(nickName: account.nickname,
                                      amount: account.currentBalanceString,
                                      amountInBase: account.baseCurrencyString,
                                      showAmountInBase: account.type == .foreign,
                                      inAmount: "In \(account.currencyString(amount: monthIn))",
                                      outAmount: "Out \(account.currencyString(amount: monthOut))")
    }

}

// the table header view is bit complicate, create a view model for it
struct AccountHeaderViewModel {
    let nickName: String
    let amount: String
    let amountInBase: String
    let showAmountInBase: Bool
    let inAmount: String
    let outAmount: String
}

// MARK: - Helppers
fileprivate extension Date {
    // check a date object is in the current month
    var isCurrentMonth: Bool {
        // convert to year and month (for example 2019 08) string and compare the string
        let dateFormatter = DateFormatter.yearMonth
        return dateFormatter.string(from: Date()) == dateFormatter.string(from: self)
    }
}

fileprivate extension DateFormatter {
    static var yearMonth: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY MM"
        return formatter
    }
    
    static var monthYear: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM YY"
        return formatter
    }
}
