//  Copyright © 2019 Sam Xu. All rights reserved.
//

import XCTest
@testable import MTCodeChallenge

class MTCodeChallengeTests: XCTestCase {

    let apiClient = APIClient()
    
    // test the api client loading and converting account and transactions
    func testAPIClient() {
        apiClient.loadAccounts { (accounts) in
            XCTAssertEqual(accounts.count, 3)
        }
        
        apiClient.loadTransactions(for: 1) { (transactions) in
            XCTAssertEqual(transactions.count, 1)
            transactions.forEach {
                XCTAssertEqual($0.accountId, 1)
            }
        }
        
        apiClient.loadTransactions(for: 2) { (transactions) in
            XCTAssertEqual(transactions.count, 5)
            transactions.forEach {
                XCTAssertEqual($0.accountId, 2)
            }
        }
        
        apiClient.loadTransactions(for: 3) { (transactions) in
            XCTAssertEqual(transactions.count, 0)
            transactions.forEach {
                XCTAssertEqual($0.accountId, 2)
            }
        }
        
    }

}
