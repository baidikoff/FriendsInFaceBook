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
    var app: XCUIApplication!
    //var viewController = LoginViewController()
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testLogoutButton() {
        
        
        self.app.navigationBars["Friends"].buttons["Log Out"].tap()
        self.app.alerts["Log Out"].buttons["Yes"].tap()
       
    }
    
}
