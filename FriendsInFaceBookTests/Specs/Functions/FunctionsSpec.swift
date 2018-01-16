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
        let checkingValue: Double = 3
        
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
                let function: () -> Int =  returnValue(value)
                let resultValue = function()
                expect(value).to(equal(resultValue))
            }
        }
        
        describe("call") {
            it("returning value should be equal to set value") {
                let function: () -> Int =  {return value}
                let resultValue = call(function)
                expect(value).to(equal(resultValue))
            }
        }
        
        describe("scope") {
            it("result value should be equal 2 after function scope is called") {
                var value = 2
                scope{value += 1}
                let resultValue = value
                expect(value).to(equal(resultValue))
            }
        }
        
        describe("curry") {
            it("result value should be equal 3 when using function curry") {
                let function: (Double, Double) -> Double = self.divideNumber
                let curryFunction = curry § function
                let resultFunction = curryFunction(9)
                let resultValue = resultFunction(3)
               expect(checkingValue).to(equal(resultValue))
            }
        }
        
        describe("uncurry") {
            it("result value should be equal 6 when using function uncurry") {
                let function: (String) -> (Double) -> Double = self.func3
                let uncurryFunction = uncurry § function
                let resultValue = uncurryFunction("function uncarry is worked", 1)
                expect(checkingValue).to(equal(resultValue))
            }
        }
        
        describe("flip") {
            it("result value should be equal 3 when using function flip") {
                let tuple: (Double, Double) = (3, 9)
                let flipedFunction = flip § self.divideNumber
                let resultValue = flipedFunction(tuple.0, tuple.1)
                expect(checkingValue).to(equal(resultValue))
            }
        }
    }
    func divideNumber(a: Double,  b: Double) -> Double {
        let result = a / b
        return result
    }
    func func3( _ message: String) -> (Double) -> Double {
        print(message)
        return doubleNumber
    }
    func doubleNumber(_ b: Double) -> Double{
        return b * 3
    }
}

