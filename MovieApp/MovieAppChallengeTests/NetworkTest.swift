//
//  InChurchIosChallengeTests.swift
//  InChurchIosChallengeTests
//
//  Created by Pedro Azevedo on 07/04/20.
//  Copyright © 2020 Pedro Azevedo. All rights reserved.
//

import XCTest
@testable import InChurchIosChallenge

class NetworkTest: XCTestCase {

    var errorResponse: Error?
    var moviesResponse: [Movie]?
    var genresResponse: [Genre]?

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        super.setUp()
        moviesResponse = nil
        errorResponse = nil
        genresResponse = nil
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        moviesResponse = nil
        errorResponse = nil
        genresResponse = nil
        super.tearDown()
    }

    func testListQuery() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        let promise = expectation(description: "Populars query")
        
        // when
        MovieClient.getPopular(page: 1) { [weak self] (movies, error) in
            
            self?.errorResponse = error
            self?.moviesResponse = movies
            promise.fulfill()
        }
        
        wait(for: [promise], timeout: 5)
        
        // then
        XCTAssertNil(errorResponse, "Error: \(errorResponse?.localizedDescription ?? "")")
        XCTAssertNotNil(moviesResponse, "Error: received no movies")
        XCTAssertFalse(moviesResponse?.isEmpty ?? true, "Error: Populars query was empty")
    }
    
    
    func testSearchQuery() {
           
           // given
           let promise = expectation(description: "Search query")
           
           // when
        MovieClient.getFilteredMovie(movie: "Star Wars") { [weak self] (movies, error) in
               
               self?.errorResponse = error
               self?.moviesResponse = movies
               promise.fulfill()
           }
           
           wait(for: [promise], timeout: 5)
           
           // then
           XCTAssertNil(errorResponse, "Error: \(errorResponse?.localizedDescription ?? "")")
           XCTAssertNotNil(moviesResponse, "Error: received no movies")
           XCTAssertFalse(moviesResponse?.isEmpty ?? true, "Error: Search query was empty")
       }
    

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
