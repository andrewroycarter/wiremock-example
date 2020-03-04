//
//  RedditUITests.swift
//  RedditUITests
//
//  Created by Andrew Carter on 3/4/20.
//  Copyright © 2020 AshleyCo. All rights reserved.
//

import XCTest

class RedditUITests: XCTestCase {

    func testExample() {
        let app = XCUIApplication()
        app.launch()
        
        let mockedPost = app.staticTexts["Hello from Wiremock!"]
        XCTAssertTrue(mockedPost.waitForExistence(timeout: 5.0))
    }

}
