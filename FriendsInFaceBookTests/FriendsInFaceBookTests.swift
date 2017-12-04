////
////  FriendsInFaceBookTests.swift
////  FriendsInFaceBookTests
////
////  Created by Viktoria on 11/27/17.
////  Copyright © 2017 Victoria Kravets. All rights reserved.
////
//
//import XCTest
//
//@testable import FriendsInFaceBook
//
//class FriendsInFaceBookTests: XCTestCase {
//    var sessionUnderTest = URLSession(configuration: URLSessionConfiguration.default)
//    let requestUserObject = ApiLayer()
//    override func setUp() {
//        super.setUp()
//    }
//    
//    override func tearDown() {
//        super.tearDown()
//    }
//    
//    func testFacebookApi() {
//        let token = self.requestUserObject.getTokenFromFacebook()
//        let urlHost = self.requestUserObject.urlHost
//        let url = URL(string: urlHost + token!)
//        let promise = expectation(description: "Status code: 200")
//        
//        let dataTask = sessionUnderTest.dataTask(with: url!) { data, response, error in
//            if let error = error {
//                XCTFail("Error: \(error.localizedDescription)")
//                return
//            } else if let statusCode = (response as? HTTPURLResponse)?.statusCode {
//                if statusCode == 200 {
//                    promise.fulfill()
//                } else {
//                    XCTFail("Status code: \(statusCode)")
//                }
//            }
//        }
//        dataTask.resume()
//        waitForExpectations(timeout: 5, handler: nil)
//    }
//    func testGetTokenFromFacebook(){
//        let token = requestUserObject.getTokenFromFacebook()
//        XCTAssertTrue(token is String)
//        XCTAssertNotNil(token)
//    }
//    
//   
//    
//}

