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

fileprivate typealias SpecResult = Result<Int, Error>

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
            func itShouldMapTransform<NewValue: Equatable, NewError: Equatable>
                (
                expected: (value: NewValue, error: NewError),
                transform: @escaping (SpecResult) -> Result<NewValue, NewError>
                )
            {
                it("should map value"){
                    let result: Result = transform(valueResult)
                    expect(result).to(beSuccess(value: expected.value))
                }
                
                it("should map type"){
                    let result: Result = transform(errorResult)
                    expect(result).to(beFailure(error: expected.error))
                }
            }
            
            describe("map"){
                let specError = WrapperError.fail(error)
                typealias TransformedResult = Result<String, Error>
                let transform: (SpecResult) -> TransformedResult = { $0.map { "\($0)" } }
                let transformError: (SpecResult) -> Result<Int, WrapperError> = { $0.mapError {.fail($0)} }
                context("map") {
                     itShouldMapTransform(expected: (value: "\(value)", error: error), transform: transform)
                }
                
                context("bimap") {
                    let transformValueError:(SpecResult) -> Result<String, WrapperError> = { $0.bimap(success: { "\($0)" }, failure: { .fail($0) }) }
                     itShouldMapTransform(expected: (value: "\(value)", error: specError), transform: transformValueError)
                }
                
                context("mapError") {
                    itShouldMapTransform(expected: (value: value, error: specError), transform: transformError)
                }
            }
            
            describe("flatmap") {
                let expectedValue = "\(value)"
                let expectedError = WrapperError.fail(.fail)
                
                func itShouldFlatmapTransform<NewValue: Equatable, NewError: Equatable>(
                    expected: (value: NewValue, error: NewError),
                    transform: @escaping (SpecResult) -> Result<NewValue, NewError>
                ) {
                    it("should flatmap value"){
                        let result = transform(valueResult)

                        expect(result).to(beSuccess(value: expected.value))
                    }
                    
                    it("should flatmap error"){
                        let result = transform(errorResult)
                        print(result)
                        expect(result).to(beFailure(error: expected.error))
                    }
                }
                
                func transformValue<Error>(_ value: Int) -> Result<String, Error> {
                    return lift("\(value)")
                }
                
                func transformError<Value>(_ error: Error) -> Result<Value, WrapperError> {
                    return lift(WrapperError.fail(error))
                }
                
                context("flatmap") {
                    let transform: (SpecResult) -> Result<String, Error> = { $0.flatMap(transformValue) }

                    itShouldFlatmapTransform(expected: (value: expectedValue, error: error), transform: transform)
                }

                context("biflatmap") {
                    let transformBiFlatMap: (SpecResult) -> Result<String, WrapperError> = {
                        $0.biflatMap(success: transformValue, failure: transformError)
                    }
                    
                    itShouldFlatmapTransform(expected: (value: expectedValue, error: expectedError), transform: transformBiFlatMap)
                }
                
                context("flatmapError") {
                    let transformFlatMapError: (SpecResult) -> Result<Int, WrapperError> = {
                        $0.flatMapError(transformError)
                    }
                    
                    itShouldFlatmapTransform(expected: (value: value, error: expectedError), transform: transformFlatMapError)
                }
            }
        }
    }
}
