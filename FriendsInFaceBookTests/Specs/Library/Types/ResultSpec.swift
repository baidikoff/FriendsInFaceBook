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

fileprivate enum WrapperError: Swift.Error, Equatable {
    case fail(Error)

    public static func ==(lhs: WrapperError, rhs: WrapperError) -> Bool {
        switch (lhs, rhs) {
        case (.fail(let lhs), .fail(let rhs)): return lhs == rhs
        }
    }
}

fileprivate typealias SpecResult = FriendsInFaceBook.Result<Int, Error>

class ResultSpec: QuickSpec {
    override func spec() {
        let value = 1
        let valueResult: SpecResult = lift(value)
        
        let error = Error.fail
        let errorResult: SpecResult = lift(error)
        
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
                let factory = { SpecResult(value: $0, error: $1, default: defaultError) }
                
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
            
            describe("map") {
                func itShouldTransform<NewValue: Equatable, NewError: Equatable>(
                    expected: (value: NewValue, error: NewError),
                    transform: @escaping (SpecResult) -> Result<NewValue, NewError>
                ) {
                    typealias TransformedResult = Result<NewValue, NewError>
                    
                    it("should map value for .success") {
                        let result: TransformedResult = transform(valueResult)
                        expect(result).to(beSuccess(value: expected.value))
                    }
                    
                    it("should map type for .failure") {
                        let result: TransformedResult = transform(errorResult)
                        expect(result).to(beFailure(error: expected.error))
                    }
                }
                
                context("map") {
                    itShouldTransform(expected: ("\(value)", error)) { $0.map { "\($0)" } }
                }
                
                context("bimap") {
                    itShouldTransform(expected: ("\(value)", WrapperError.fail(.fail))) {
                        $0.bimap(
                            success: { "\($0)" },
                            failure: { .fail($0) }
                        )
                    }
                }
                
                context("mapError") {
                    itShouldTransform(expected: (value, .fail(.fail))) {
                        $0.mapError { WrapperError.fail($0) }
                    }
                }
                
                it("value should be equal Optional(2) and error is equal nil"){
//                    expect(valueMapResult.value).to(equal(valueMap.value))
//                    expect(valueMapResult.error).to(beNil())
                }
            }
        }
    }
}
