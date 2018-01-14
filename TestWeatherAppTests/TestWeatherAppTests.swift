//
//  TestWeatherAppTests.swift
//  TestWeatherAppTests
//
//  Created by Javid Sheikh on 14/01/2018.
//  Copyright © 2018 Javid Sheikh. All rights reserved.
//

import XCTest
import Alamofire
@testable import TestWeatherApp

class TestWeatherAppTests: XCTestCase {
    
    var sessionUnderTest: NetworkRequestHelper!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        sessionUnderTest = NetworkRequestHelper()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sessionUnderTest = nil
        super.tearDown()
    }
    
    func testFetchWeatherJson() {
        let promise = expectation(description: "Response received")
        sessionUnderTest.fetchWeatherJSONData(for: "London", errorHandler: {
            XCTFail()
        }) { _ in
            promise.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testFetchWeatherIcon() {
        let promise = expectation(description: "Image data received in response")
        sessionUnderTest.fetchWeatherIcon(withCode: "01n") { data in
            if let _ = UIImage(data: data) {
                promise.fulfill()
            } else {
                XCTFail()
            }
        }
        waitForExpectations(timeout: 5, handler: nil)
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
