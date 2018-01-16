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
                value.do{value in resultValue += value}
                expect(3).to(equal(resultValue))
            }
        }
    }
}

//public func apply<Result>(_ transform: ((Wrapped) -> Result)?) -> Result? {
//    return self.flatMap { value in
//        transform.map { $0(value) }
//    }
//}
//
//public func apply<Value, Result>(_ value: Value?) -> Result?
//    where Wrapped == (Value) -> Result
//{
//    // ERROR: swiftc 4.0 too stupid, check back later
//    // return value.apply(self)
//    return self.flatMap { value.map($0) }
//}
//


