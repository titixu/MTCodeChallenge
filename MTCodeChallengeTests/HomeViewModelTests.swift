//
//  HomeViewModelTests.swift
//  MTCodeChallengeTests
//
//  Created by An Xu on 25/7/19.
//  Copyright © 2019 Sam Xu. All rights reserved.
//

import XCTest
@testable import MTCodeChallenge

class HomeViewModelTests: XCTestCase {
    
    func testLoadAccounts() {
        var homeViewModel = HomeViewModel(apiClient: APIClient(), onLoading:{
            print("on loading")
        })
        { homeViewModel in
            XCTAssertEqual(homeViewModel.accountsGrouped.count, 2)
            
            var account = homeViewModel.accountsGrouped[0][0]
            XCTAssertEqual(account.institution, "Starbucks Card")
            XCTAssertEqual(account.nickname, "マイカード")
            
            account = homeViewModel.accountsGrouped[0][1]
            XCTAssertEqual(account.institution, "Starbucks Card")
            XCTAssertEqual(account.nickname, "マークからカード")
            
            account = homeViewModel.accountsGrouped[1][0]
            XCTAssertEqual(account.institution, "Test Bank")
            XCTAssertEqual(account.nickname, "外貨普通(USD)")
            
            let total = homeViewModel.totalAmount
            XCTAssertTrue(total.contains("JPY"))
            XCTAssertTrue(total.contains("5341"))
        }
        
        // this trigger the check in the callback above
        homeViewModel.updateAccounts()
    }
    
}
