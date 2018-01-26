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

func divide(divider: Double,  by dividend: Double) -> Double {
    return divider / dividend
}
func func3( _ message: String) -> (Double) -> Double {
    return doubleNumber
}
func doubleNumber(_ b: Double) -> Double{
    return b * 3
}

class FunctionsSpec: QuickSpec {
    override func spec() {
        let value = 1
        let checkingValue = 3.0
        
        describe("identity") {
            it("it should be equal to value") {
                let valueResult = identity(value)
                
                expect(valueResult).to(equal(value))
            }
        }
        
        describe("cast") {
            it("it should be equal value with type as? Int") {
                let value: Any? = 1
                
                let resultValue: Int? = value.flatMap(cast)
                
                expect(value as? Int).to(equal(resultValue))
            }
        }
        
        describe("ignoreInput") {
            it("it should be true when input is ignored") {
                let function: (Int) -> Bool = ignoreInput { true }
                
                let resultValue = function(value)
                
                expect(resultValue).to(beTrue())
            }
        }
        
        describe("returnValue") {
            it("function should return value is equal to set value") {
                let resultValue =  returnValue(value)()
                
                expect(value).to(equal(resultValue))
            }
        }
        
        describe("call") {
            it("returning value should be equal to set value") {
                let function: () -> Int =  { value }
                
                let resultValue = call(function)
                
                expect(value).to(equal(resultValue))
            }
        }
        
        describe("scope") {
            it("result value should be equal 2 after function scope is called") {
                let value = 2
                scope { let value = 1 }
                let resultValue = value
                expect(value).to(equal(resultValue))
            }
        }
        
        describe("curry") {
            it("result value should be equal 3 when using function curry") {
                let function: (Double, Double) -> Double = divide
                
                let curryFunction = curry § function
                let resultValue = curryFunction(9)(3)

                expect(checkingValue).to(equal(resultValue))
            }
        }
        
        describe("uncurry") {
            it("result value should be equal 6 when using function uncurry") {
                let function: (String) -> (Double) -> Double = func3
                
                let uncurryFunction = uncurry § function
                let resultValue = uncurryFunction("function uncurry is worked", 1)
                
                expect(checkingValue).to(equal(resultValue))
            }
        }
        
        describe("flip") {
            it("result value should be equal 3 when using function flip") {
                let tuple: (Double, Double) = (3, 9)
                
                let flipedFunction = flip § divide
                let resultValue = flipedFunction(tuple.0, tuple.1)
                
                expect(checkingValue).to(equal(resultValue))
            }
        }
    }
}

