//
//  TupleSpec.swift
//  FriendsInFaceBookTests
//
//  Created by Viktoria on 1/15/18.
//  Copyright © 2018 Victoria Kravets. All rights reserved.
//

import Quick
import Nimble

@testable import FriendsInFaceBook

class TupleSpec: QuickSpec {
    override func spec() {
        let tuple: (Int?, Int?) = (1, 2)
        let resultTuple: (Int, Int) = (1, 2)
        describe("lift") {
            it("should lift") {
                let optionalTuple = lift(tuple)
                expect(optionalTuple).to(equal(resultTuple))
            }
        }
    }
   
}


