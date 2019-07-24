//  Copyright © 2019 Sam Xu. All rights reserved.
//

import XCTest
@testable import MTCodeChallenge

class MTCodeChallengeTests: XCTestCase {

    let apiClient = APIClient()
    
    func testAPIClient() {
        apiClient.loadAccounts() { accounts in
            XCTAssertNotNil(accounts)
        }
    }

}
