//
//  omdbMovieChallengeTests.swift
//  omdbMovieChallengeTests
//
//  Created by *_* on 1/20/21.
//

import XCTest
@testable import omdbMovieChallenge

class omdbMovieChallengeTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testMoviesModel() {
        var movies = [MoviesModel.List.Movie]()
        // TODO - Change a value in MoviesList.json from string to a numerical value to force the error (ie "2012" to 2012)
        movies = MoviesModel.stubbedMoviesList
        XCTAssertTrue(movies.count>0)
    }
    
    
    

}
