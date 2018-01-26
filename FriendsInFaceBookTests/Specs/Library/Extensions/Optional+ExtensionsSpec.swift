//
//  Optional+ExtensionsSpec.swift
//  FriendsInFaceBookTests
//
//  Created by Viktoria on 1/16/18.
//  Copyright © 2018 Victoria Kravets. All rights reserved.
//

import Quick
import Nimble

@testable import FriendsInFaceBook

class OptionalSpec: QuickSpec {
    override func spec() {
        let expectedValue = 3
        describe("flatten") {
            it("result value should be type Int?") {
                let value: Int?? = 1
                
                let resultValue = value.flatten()
                
                expect(Optional(1)).to(equal(resultValue))
            }
        }
        
        describe("do") {
            it("result value should be equal 3") {
                let value: Int? = 1
                var resultValue = 2
                
                value.do{ resultValue += $0 }
                
                expect(expectedValue).to(equal(resultValue))
            }
        }
        
        describe("apply") {
            it("result value should be equal 3") {
                let value: Int? = 1
                
                let resultValue = value.apply { $0 + 2}
                
                expect(expectedValue).to(equal(resultValue))
            }
        }
    }
}
