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
    
    var controllerUnderTest: ListOfFriendsTableViewController?
    
    override func setUp() {
        super.setUp()
        self.controllerUnderTest = UIStoryboard(name: "Main",
                                            bundle: nil).instantiateViewController(withIdentifier: "TableView") as! ListOfFriendsTableViewController
    }
    
    override func tearDown() {
        super.tearDown()
        controllerUnderTest = nil
    }
    func testRequestUsers(){
        
    }
    
   
    
}

