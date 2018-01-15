//
//  ResultSpec.swift
//  FriendsInFaceBookTests
//
//  Created by Oleksa 'trimm' Korin on 12/29/17.
//  Copyright © 2017 Victoria Kravets. All rights reserved.
//

import Quick
import Nimble

@testable import FriendsInFaceBook

fileprivate enum Error: Swift.Error {
    case fail
    case unknown
}

fileprivate typealias Result = FriendsInFaceBook.Result<Int, Error>

class ResultSpec: QuickSpec {
    override func spec() {
        let value = 1
        let valueResult: Result = lift(value)
        
        let error = Error.fail
        let errorResult: Result = lift(error)
        
        let defaultError = Error.unknown
        
        describe("lift") {
            it("should return .success, when Value is passed as parameter") {
                expect(valueResult).to(beSuccess(value: value))
            }
            
            it("should return .failure, when Value is passed as parameter") {
                expect(errorResult).to(beFailure(error: error))
            }
        }
        
        describe("Result") {
            describe("properties") {
                it("should contain value, when .success") {
                    expect(valueResult.value).to(equal(value))
                    expect(valueResult.error).to(beNil())
                }
                
                it("should contain value, when .success") {
                    expect(errorResult.value).to(beNil())
                    expect(errorResult.error).to(equal(error))
                }
            }
            
            describe("init(value: Value?, error: Error?, `default`: Error)") {
                let factory = { Result(value: $0, error: $1, default: defaultError) }
                
                it("should be .success, when Value is non-nil and error is nil") {
                    expect(factory(value, nil)).to(beSuccess(value: value))
                }
                
                it("should be .failure, when error is non-nil") {
                    let result = { factory($0, error) }
                    
                    expect(result(value)).to(beFailure(error: error))
                    expect(result(nil)).to(beFailure(error: error))
                }
                
                it("should be .failure with default error, when both error and value are nil") {
                    expect(factory(nil,  nil)).to(beFailure(error: defaultError))
                }
            }
        }
    }
}
