//
//  AccountViewModelTests.swift
//  LogicTests
//
//  Created by An Xu on 26/7/19.
//  Copyright © 2019 Sam Xu. All rights reserved.
//

import XCTest
@testable import MTCodeChallenge

class AccountViewModelTests: XCTestCase {

    func testViewModelWithAccount1() {
        
        let account = Account(id: 1,
                              nickname: "test",
                              institution: "test",
                              currency: "JYD",
                              currentBalance: 100,
                              currentBalanceInBase: 100)
        
        var viewModel = AccountViewModel(account: account, apiClient: APIClient(), onLoading: { viewModel in
                print("onLoading")
        }) { viewModel in
            XCTAssertEqual(viewModel.account.id, 1)
            
            XCTAssertEqual(viewModel.transactionsGrouped.count, 1)
            XCTAssertEqual(viewModel.transactionsGrouped[0][0].accountId, 1)
            XCTAssertEqual(viewModel.transactionsGrouped[0][0].amount, -6850.0)
            XCTAssertEqual(viewModel.transactionsGrouped[0][0].categoryId, 192)
            XCTAssertEqual(viewModel.transactionsGrouped[0][0].id, 11)
        }
        
        viewModel.fetchAccount()
    }

    func testViewModelWithAccount2() {
        
        let account = Account(id: 2,
                              nickname: "test",
                              institution: "test",
                              currency: "JYD",
                              currentBalance: 100,
                              currentBalanceInBase: 100)
        
        var viewModel = AccountViewModel(account: account, apiClient: APIClient(), onLoading: { viewModel in
            print("on Loading")
        }) { viewModel in
            XCTAssertEqual(viewModel.account.id, 2)
            
            XCTAssertEqual(viewModel.transactionsGrouped.count, 2)
            XCTAssertEqual(viewModel.transactionsGrouped[0][0].accountId, 2)
            XCTAssertEqual(viewModel.transactionsGrouped[0][0].amount, -442.0)
            XCTAssertEqual(viewModel.transactionsGrouped[0][0].categoryId, 112)
            XCTAssertEqual(viewModel.transactionsGrouped[0][0].id, 21)
            
            XCTAssertEqual(viewModel.transactionsGrouped[0][2].accountId, 2)
            XCTAssertEqual(viewModel.transactionsGrouped[0][2].amount, -421.0)
            XCTAssertEqual(viewModel.transactionsGrouped[0][2].categoryId, 112)
            XCTAssertEqual(viewModel.transactionsGrouped[0][2].id, 23)
            
        }
        
        viewModel.fetchAccount()
    }
}
