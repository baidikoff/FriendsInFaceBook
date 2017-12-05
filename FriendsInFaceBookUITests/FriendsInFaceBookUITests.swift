//
//  FriendsInFaceBookUITests.swift
//  FriendsInFaceBookUITests
//
//  Created by Viktoria on 12/3/17.
//  Copyright © 2017 Victoria Kravets. All rights reserved.
//
import UIKit
import XCTest


import FriendsInFaceBook

class FriendsInFaceBookUITests: XCTestCase {
    var app: XCUIApplication?
    var controllerUnderTest: ListOfFriendsTableViewController?
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        self.controllerUnderTest?.facebookSocialService = MockSocialService()
        self.controllerUnderTest?.facebookSocialService.requestUsers().then{_ -> Void in
            self.controllerUnderTest?.getFriendsFromStorage()
        }
        
        self.app = XCUIApplication()
        self.app?.launch()

        
    }
    
    override func tearDown() {
        controllerUnderTest = nil
        super.tearDown()
    }
//    func testfe(){
//        
//        //XCUIApplication().tables/*@START_MENU_TOKEN@*/.staticTexts["Victoria Kravets"]/*[[".cells.staticTexts[\"Victoria Kravets\"]",".staticTexts[\"Victoria Kravets\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.swipeDown()
//        
//       // let myExpectation = self.expectation(description: "myExpectation")
////        self.controllerUnderTest?.facebookSocialService = MockSocialService()
////        self.controllerUnderTest?.facebookSocialService.requestUsers()
////        self.controllerUnderTest?.getFriendsFromStorage()
//        
//        //.then{_ -> Void in
////            self.controllerUnderTest?.configureRealmNotification()
////            XCTAssertEqual(self.app?.tables.element(at: 0).title, "Ivan Ivanov")
////            myExpectation.fulfill()
////        }
////        waitForExpectations(timeout: 20, handler: nil)
//    }
//    func testh(){
//
//        XCUIApplication().tables/*@START_MENU_TOKEN@*/.cells.staticTexts["Victoria Kravets"]/*[[".cells.staticTexts[\"Victoria Kravets\"]",".staticTexts[\"Victoria Kravets\"]"],[[[-1,1],[-1,0]]],[1]]@END_MENU_TOKEN@*/.swipeDown()
//        let updatedCell = XCUIApplication().tables.cells.staticTexts["Ivan Ivanov"].exists
//        XCTAssertTrue(updatedCell)
//    }
    
    
}

