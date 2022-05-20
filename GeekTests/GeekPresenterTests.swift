//
//  GeekPresenterTests.swift
//  Geek
//
//  Created by Srikanth S on 20/05/22.
//


import XCTest
@testable import Geek

class GeekPresenterTests: XCTestCase {

    var presenter : GeekPresenter!
    var venue : Venue!
    var performer : [Performer]!
    
   
    override func setUp() {
        self.presenter = GeekPresenter(dataService: DataService())
        venue = Venue(state: "", nameV2: "", postalCode: "", name: "", timezone: "", url: "", score: 0, address: "", country: "")
        performer = [Performer(type: "", name: "", image: "", id: 0)]
        
    }
    override func tearDown() {
        self.presenter = nil
        self.venue = nil
        self.performer = nil
    }
    
    func testFetchWithNoService() {
        
        let expectation = XCTestExpectation(description: "No service Movie")
        
        presenter.fetchmovie(withId: "")
        
        presenter.updateLoadingStatus = {

        }
        
        presenter.showAlertClosure = {
            if self.presenter.error != nil {
                expectation.fulfill()
            }
        }
        
        wait(for: [expectation], timeout: 5.0)
        
    }
    func testFetchGeek() {
        
        let expectation = XCTestExpectation(description: "Geek fetch")
        
        // giving a service mocking Movie
        presenter.fetchmovie(withId: "swift")
        
        presenter.showAlertClosure = {
            if self.presenter.error != nil {
                XCTAssert(false, "ViewModel should not be able to fetch without service")
            }
        }
        
        presenter.didFinishFetch = {
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5.0)
    }
    
    func testWithMovie(){
        self.presenter.geekList = GeekModel(events: [Event(type: "", id: 0, datetimeUTC: "", venue: venue, performers: performer, timeTbd: false, shortTitle: "", visibleUntilUTC: "")])
        XCTAssertTrue((self.presenter.geekList?.events)!.count >= 1)
    }

    func testExample() throws {
        self.presenter.geekList = GeekModel(events: [Event(type: "", id: 0, datetimeUTC: "", venue: venue, performers: performer, timeTbd: false, shortTitle: "", visibleUntilUTC: "")])
        XCTAssertTrue((self.presenter.geekList?.events.count)! < 1)
    }


}
