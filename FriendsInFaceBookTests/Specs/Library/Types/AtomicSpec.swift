//
//  AtomicSpec.swift
//  FriendsInFaceBookTests
//
//  Created by Admin on 21.02.2018.
//  Copyright © 2018 Victoria Kravets. All rights reserved.
//

import Quick
import Nimble

@testable import FriendsInFaceBook

class Weather {
    
    // MARK: -
    // MARK: Properties
    
    var season: String
    var temperature: Int
    
    // MARK: -
    // MARK: Init and Deinit
    
    init() {
        self.season = "Winter"
        self.temperature = 0
    }
}

class AtomicSpec: QuickSpec {
    override func spec() {
        describe("AtomicSpec") {
            it("should pass if season has changed") {
                let newSeason = "Summer"
                
                let atomic = Atomic(Weather())
                atomic.modify { $0.season = newSeason }
                
                expect(newSeason).to(equal(atomic.value.season))
            }
        }
    }
}
