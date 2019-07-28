//  Copyright © 2019 Sam Xu. All rights reserved.
//

import Foundation

struct HomeViewModel {
    let apiClient: APIClient
    
    // store the accounts and update it's observer
    // TODO: group it by Institution, and ordered by nick name
    var accountsGrouped: [[Account]] = [] {
        didSet {
            onUpdate(self)
        }
    }
    // call while loading data
    var onLoading: () -> Void
    
    // callback when the accounts updated
    var onUpdate: (HomeViewModel) -> Void
    
    init(apiClient: APIClient,
         onLoading: @escaping () -> Void,
         onUpdate: @escaping (HomeViewModel) -> Void) {
        self.apiClient = apiClient
        self.onLoading = onLoading
        self.onUpdate = onUpdate
    }
    
    mutating func updateAccounts() {
        onLoading() // update loading state
        
        apiClient.loadAccounts { (accounts) in
            
            // first group the account by it institution property
            let groupedDictionary = Dictionary(grouping: accounts, by: { (account) -> String in
                return account.institution
            })
            
            // sort the keys (institution) and extract values (Accounts)
            let reuslt = groupedDictionary.keys
                .sorted()
                .map {
                    // Also sort these account by its nickname
                    // it is ok to force unwarp here as the key is there
                    return groupedDictionary[$0]!.sorted(by: { (left, right) -> Bool in
                        // After sorted by nickname the order is different to the screenshot image (screen_1.png), not sure why
                        left.nickname < right.nickname
                    })
            }
            
            self.accountsGrouped = reuslt
        }
    }
}

// Table view data source
extension HomeViewModel {
    func numberOfSections() -> Int {
        return accountsGrouped.count
    }
    
    func numberOfRowsInSection(_ section: Int) -> Int {
        return accountsGrouped[section].count
    }
    
    func titleForHeader(inSection section: Int) -> String? {
        return accountsGrouped[section].first?.institution
    }
    
    func account(indexPath: IndexPath) -> Account {
        return accountsGrouped[indexPath.section][indexPath.row]
    }
    
    func amountString(account: Account) -> String {
        return account.currentBalanceString
    }
}

// Table Header view data source
extension HomeViewModel {
    
    var totalAmount: String {
        let total = accountsGrouped.reduce(0.0) { (result, accounts) -> Double in
            result + accounts.reduce(0.0, { (resultInner, account) -> Double in
                resultInner + account.currentBalanceInBase
            })
        }
        
        return total.currency
    }
    
}
