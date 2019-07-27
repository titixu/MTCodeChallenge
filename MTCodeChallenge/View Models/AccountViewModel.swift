//  Copyright © 2019 Sam Xu. All rights reserved.
//

import Foundation

struct AccountViewModel {
    var apiClient:APIClient
    var accountID: Int
    var transactionsGrouped: [[Transaction]] = []
    
    var onLoading: (AccountViewModel) -> Void
    var onComplete: (AccountViewModel) -> Void
    
    init(accountID: Int,
         apiClient: APIClient,
         onLoading: @escaping (AccountViewModel) -> Void,
         onComplete: @escaping (AccountViewModel) -> Void) {
        self.accountID = accountID
        self.apiClient = apiClient
        self.onLoading = onLoading
        self.onComplete = onComplete
    }
    
    mutating func fetchAccount() {
        onLoading(self)
        
        apiClient.loadTransactions(for: accountID) { (transactions) in
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

// Table View Data
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
}

fileprivate extension DateFormatter {
    static var yearMonth: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY MM"
        return formatter
    }
}
