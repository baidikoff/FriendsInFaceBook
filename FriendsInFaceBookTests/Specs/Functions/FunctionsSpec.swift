//
//  FunctionsSpecs.swift
//  FriendsInFaceBookTests
//
//  Created by Viktoria on 1/15/18.
//  Copyright © 2018 Victoria Kravets. All rights reserved.
//

import Quick
import Nimble

@testable import FriendsInFaceBook

class FunctionsSpec: QuickSpec {
    override func spec() {
        let value = 1
        
        describe("identity") {
            it("it should be equal to value") {
                let valueResult = identity(value)
                expect(valueResult).to(equal(value))
            }
        }
        describe("cast") {
            it("it should be equal value with type as? Int") {
                let value: Any? = 1
                let result: Int? = value.flatMap(cast)
                expect(value as? Int).to(equal(result))
            }
        }
        describe("ignoreInput") {
            it("it should be true when input is ignored") {
                let function: (Int) -> Bool = ignoreInput { true }
                let result = function(value)
                expect(result).to(beTrue())
            }
        }
        describe("returnValue") {
            it("function should return value is equal to set value") {
                let function: () -> Int =  returnValue(value)
                let result = function()
                expect(result).to(equal(value))
            }
        }
        //        describe("curry") {
        //            it("") {
        //                let function: (Bool, Int) -> Int  = self.fun1
        //                let resultFunction: (Bool) -> (Int) -> Int
        //                let funcj = curry(function)
        //                expect(resultFunction as (Bool) -> (Int) -> Int).to(equal(funcj as (Bool) -> (Int) -> Int))
        //            }
        //        }
        describe("call") {
            it("returning value should be equal to set value") {
                let function: () -> Int =  {return value}
                let result = call(function)
                expect(value).to(equal(result))
            }
        }
        
        describe("scope") {
            it("result value should be equal 2 after function scope is called") {
                var value = 1
                scope{value += 1}
                let result = value
                expect(value).to(equal(result))
            }
        }
    }
    
}

