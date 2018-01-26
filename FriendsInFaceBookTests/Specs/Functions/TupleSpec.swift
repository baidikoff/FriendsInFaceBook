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
        
        describe("lift") {
            it("should lift") {
                let tuple: (Int?, Int?) = (1, 2)
                let resultTuple: (Int, Int) = (1, 2)
                
                let optionalTuple = lift(tuple)
                
                expect(optionalTuple).to(equal(resultTuple))
            }
        }
        
        describe("lift with paremeter (_ a: A?, _ b: B?)") {
            it("should lift") {
                let tuple: (a: Int?, b: Int?) = (1, 2)
                let resultTuple: (a: Int, b: Int) = (1, 2)
                
                let optionalTuple = lift(tuple)
                
                expect(optionalTuple).to(equal(resultTuple))
            }
        }
    }
}

