//  Copyright © 2019 Sam Xu. All rights reserved.
//

import XCTest

class APIClientTests: XCTestCase {
    
    // create a json decoder instant
    let decoder = JSONDecoder.custom
    
    // Test load the accounts files into accounts
    func testLoadAccount() {
        guard let data = loadJsonFile("accounts", withExtension: "json")
            else {
                XCTAssert(false, "faild to load accounts.json")
                return
        }
        
        let accountsObject = try? decoder.decode(AccountsJSONObject.self, from: data)
        
        XCTAssertNotNil(accountsObject?.accounts)
        guard let accounts = accountsObject?.accounts else {
            XCTAssert(false); return
        }
        
        // test to match the sample json data
        XCTAssertEqual(accounts.count, 3, "Should have 3 accounts")
        XCTAssertEqual(accounts[0].id, 1, "First account id is 1")
    }
    
    func testLoadTransaction() {
        
        guard let data = loadJsonFile("transactions_1", withExtension: "json")
            else {
                XCTAssert(false, "faild to load transactions_1.json")
                return
        }
        
        let transactionsJsonObject = try? decoder.decode(TransactionsJSONObject.self, from: data)
        XCTAssertNotNil(transactionsJsonObject)
        
        guard let transactions = transactionsJsonObject?.transactions else {
            XCTAssert(false); return
        }

        XCTAssertEqual(transactions.count, 1, "Should be only 1 transaction")
        XCTAssertEqual(transactions[0].accountId, 1)
    }
    
    func testJsonDateFormatter() {
        let formatter = DateFormatter.jsonDateFormatter
        let dateString = "2017-08-22T00:00:00+09:00"
        let date = formatter.date(from: dateString)
        XCTAssertNotNil(date, "should convert to date")
        
        XCTAssertEqual(date!.timeIntervalSince1970, 1503327600)
    }
    
}

// load file from the unit Test bundle
fileprivate func loadJsonFile(_ name: String, withExtension: String) -> Data? {
    let bundle = Bundle(for: APIClientTests.self)
    guard let url = bundle.url(forResource: name, withExtension: withExtension) else {
        return nil
    }
    return try? Data.init(contentsOf: url)
}

