//
//  ThemeTests.swift
//  LogicTests
//
//  Created by Sam Xu on 24/7/19.
//  Copyright © 2019 Sam Xu. All rights reserved.
//

import XCTest

class ThemeTests: XCTestCase {

    // tests that providing someone changing the theme values accidentally
    func testThemeValues() {
        XCTAssertEqual(UIColor.appBackground, UIColor.orange)
        XCTAssertEqual(UIColor.overlay, UIColor(displayP3Red: 222.0/256, green: 97.0/256, blue: 45.0/256, alpha: 1.0))
        XCTAssertEqual(UIColor.textColor, UIColor.white)
        
        XCTAssertEqual(CGFloat.padding, CGFloat(20.0))
    }
}
