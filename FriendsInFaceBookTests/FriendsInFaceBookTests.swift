//
//  FriendsInFaceBookTests.swift
//  FriendsInFaceBookTests
//
//  Created by Viktoria on 11/27/17.
//  Copyright © 2017 Victoria Kravets. All rights reserved.
//

import XCTest

@testable import FriendsInFaceBook

class FriendsInFaceBookTests: XCTestCase {
    var sessionUnderTest = URLSession(configuration: URLSessionConfiguration.default)
    let requestUserObject = RequestUsers()
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testFacebookApi() {
            let token = requestUserObject.getTokenFromFacebook()
            let url = URL(string: "https://graph.facebook.com/v2.11/me/accounts?access_token=" + token)
            let promise = expectation(description: "Status code: 200")

            let dataTask = sessionUnderTest.dataTask(with: url!) { data, response, error in
                // then
                if let error = error {
                    XCTFail("Error: \(error.localizedDescription)")
                    return
                } else if let statusCode = (response as? HTTPURLResponse)?.statusCode {
                    if statusCode == 200 {
                        promise.fulfill()
                    } else {
                        XCTFail("Status code: \(statusCode)")
                    }
                }
            }
            dataTask.resume()
            waitForExpectations(timeout: 5, handler: nil)
        }
    
   
    
}
