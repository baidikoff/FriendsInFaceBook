//
//  FriendsInFaceBookTests.swift
//  FriendsInFaceBookTests
//
//  Created by Viktoria on 11/27/17.
//  Copyright © 2017 Victoria Kravets. All rights reserved.
//

import XCTest
import PromiseKit

@testable import FriendsInFaceBook

class FriendsInFaceBookTests: XCTestCase {
    
    var controllerUnderTest: ListOfFriendsTableViewController?
    
    override func setUp() {
        super.setUp()
        self.controllerUnderTest = UIStoryboard(name: Constants.Main,
                                            bundle: nil).instantiateViewController(withIdentifier: Constants.ListOfFriendsTVCIdentifier) as! ListOfFriendsTableViewController
    }
    
    override func tearDown() {
        super.tearDown()
        controllerUnderTest = nil
    }
//    func testRequestUsers(){ //method requests users and write its to DB
//        let myExpectation = self.expectation(description: "myExpectation")
//
//        self.controllerUnderTest?.facebookSocialService = MockSocialService()
//        self.controllerUnderTest?.requestFriends().then{_ -> Void in
//            myExpectation.fulfill()
//        }
//        waitForExpectations(timeout: 10, handler: nil)
//
//        let usersInDB = ServiceForData.shared.getDataFromStorage()
//        XCTAssertEqual(usersInDB?.first!.name, MockSocialService.users[0].name)
//        XCTAssertEqual(usersInDB?.count, MockSocialService.users.count)
 
    //}
    
    
    
}

