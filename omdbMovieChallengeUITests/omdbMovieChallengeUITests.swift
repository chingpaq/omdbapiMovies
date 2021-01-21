//
//  omdbMovieChallengeUITests.swift
//  omdbMovieChallengeUITests
//
//  Created by *_* on 1/20/21.
//

import XCTest

class omdbMovieChallengeUITests: XCTestCase {

    func testIfAvengersMovieAvailable() {
        let app = XCUIApplication()
        
        let movieTitle = "The Stubbed Avengers"
        let textToSearchInDetailView = "Marvel Studios"
        
        app.launch()
        XCTAssert(app.tables.cells.staticTexts[movieTitle].waitForExistence(timeout: 10))
        app.tables.cells.staticTexts[movieTitle].tap()
        XCTAssert(app.staticTexts[textToSearchInDetailView].waitForExistence(timeout: 10))
    }
    
}
