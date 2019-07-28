//  Copyright © 2019 Sam Xu. All rights reserved.
//

import XCTest

class MTCodeChallengeUITests: XCTestCase {

    var app: XCUIApplication!
    
    override func setUp() {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testHomeUIs() {
        
        // test all ui present in Home view
        let tablesQuery = app.tables
        XCTAssertTrue(tablesQuery.staticTexts["Digital Money"].exists)
        XCTAssertTrue(tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["JPY 5341"]/*[[".staticTexts[\"total amount of money\"]",".staticTexts[\"JPY 5341\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.exists)
        XCTAssertTrue(tablesQuery.staticTexts["Starbucks Card"].exists)
        XCTAssertTrue(tablesQuery.staticTexts["Test Bank"].exists)
        XCTAssertTrue(tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["マイカード"]/*[[".cells[\"Nick Name マイカード has total amount JPY 0 Double tap to open\"].staticTexts[\"マイカード\"]",".staticTexts[\"マイカード\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.exists)
        XCTAssertTrue(app.tables/*@START_MENU_TOKEN@*/.staticTexts["マークからカード"]/*[[".cells[\"Nick Name マークからカード has total amount JPY 3035 Double tap to open\"].staticTexts[\"マークからカード\"]",".staticTexts[\"マークからカード\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.exists)
        XCTAssertTrue(app.tables/*@START_MENU_TOKEN@*/.staticTexts["外貨普通(USD)"]/*[[".cells[\"Nick Name 外貨普通(USD) has total amount USD 22.50 Double tap to open\"].staticTexts[\"外貨普通(USD)\"]",".staticTexts[\"外貨普通(USD)\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.exists)
        
    }
    
    func testAccountPageUI() {
        
        let tablesQuery = app.tables
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["外貨普通(USD)"]/*[[".staticTexts[\"Nickname\"]",".staticTexts[\"外貨普通(USD)\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        XCTAssertTrue(tablesQuery.staticTexts["USD 22.50"].exists)
        XCTAssertTrue(tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["In USD 0.00"]/*[[".staticTexts[\"deposit\"]",".staticTexts[\"In USD 0.00\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.exists)
        XCTAssertTrue(tablesQuery.staticTexts["JPY 2306"].exists)
        XCTAssertTrue(tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Out USD 0.00"]/*[[".staticTexts[\"withdraw\"]",".staticTexts[\"Out USD 0.00\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.exists)

        let tablesQuery2 = tablesQuery
        XCTAssertTrue(tablesQuery2/*@START_MENU_TOKEN@*/.staticTexts["August 17"]/*[[".otherElements[\"August 17\"].staticTexts[\"August 17\"]",".staticTexts[\"August 17\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.exists)
        XCTAssertTrue(tablesQuery2/*@START_MENU_TOKEN@*/.staticTexts["  -USD 6850.00  "]/*[[".otherElements[\"August 17\"]",".staticTexts[\"total withdraw in month\"]",".staticTexts[\"  -USD 6850.00  \"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.exists)
        XCTAssertTrue(tablesQuery2/*@START_MENU_TOKEN@*/.staticTexts["22"]/*[[".cells[\"Transaction at day 22, description 取引明細名 2017-08-22T17:19:31+09:00, amount -USD 6850.00\"]",".staticTexts[\"Transaction day\"]",".staticTexts[\"22\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.exists)
        XCTAssertTrue(tablesQuery2/*@START_MENU_TOKEN@*/.staticTexts["取引明細名 2017-08-22T17:19:31+09:00"]/*[[".cells[\"Transaction at day 22, description 取引明細名 2017-08-22T17:19:31+09:00, amount -USD 6850.00\"]",".staticTexts[\"Transaction description\"]",".staticTexts[\"取引明細名 2017-08-22T17:19:31+09:00\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.exists)
        XCTAssertTrue(tablesQuery2/*@START_MENU_TOKEN@*/.staticTexts["-USD 6850.00"]/*[[".cells[\"Transaction at day 22, description 取引明細名 2017-08-22T17:19:31+09:00, amount -USD 6850.00\"]",".staticTexts[\"Tansaction amount\"]",".staticTexts[\"-USD 6850.00\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.exists)
        XCTAssertFalse(tablesQuery2.staticTexts["Auguest 19"].exists)
        
    }

    func testNavigation() {
        
        let tablesQuery = app.tables
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["マイカード"]/*[[".cells[\"Nick Name マイカード has total amount JPY 0 Double tap to open\"].staticTexts[\"マイカード\"]",".staticTexts[\"マイカード\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        XCTAssertTrue(tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["JPY 0"]/*[[".staticTexts[\"Total amount in the account or card\"]",".staticTexts[\"JPY 0\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.exists)
        
        let balancesButton = app.navigationBars["Starbucks Card"].buttons["Balances"]
        balancesButton.tap()
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["マークからカード"]/*[[".cells[\"Nick Name マークからカード has total amount JPY 3035 Double tap to open\"].staticTexts[\"マークからカード\"]",".staticTexts[\"マークからカード\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        XCTAssertTrue(tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["JPY 3035"]/*[[".staticTexts[\"Total amount in the account or card\"]",".staticTexts[\"JPY 3035\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.exists)
        
        balancesButton.tap()
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["外貨普通(USD)"]/*[[".cells[\"Nick Name 外貨普通(USD) has total amount USD 22.50 Double tap to open\"].staticTexts[\"外貨普通(USD)\"]",".staticTexts[\"外貨普通(USD)\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        XCTAssertTrue(tablesQuery.staticTexts["USD 22.50"].exists)
        XCTAssertTrue(tablesQuery.staticTexts["JPY 2306"].exists)
        app.navigationBars["Test Bank"].buttons["Balances"].tap()
        
    }
}
