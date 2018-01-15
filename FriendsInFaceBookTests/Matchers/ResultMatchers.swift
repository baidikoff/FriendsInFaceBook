//
//  ResultMatchers.swift
//  FriendsInFaceBookTests
//
//  Created by Oleksa 'trimm' Korin on 12/29/17.
//  Copyright © 2017 Victoria Kravets. All rights reserved.
//

import Foundation

import Quick
import Nimble

@testable import FriendsInFaceBook

public struct ResultPredicate<Value> {
    
    // MARK: -
    // MARK: Properties
    
    public let value: Value
    public let description: String
    
    // MARK: -
    // MARK: Init and Deinit
    
    public init(_ value: Value, description: String) {
        self.value = value
        self.description = description
    }
    
    // MARK: -
    // MARK: Public
    
    public func map<NewValue>(_ transform: (Value) -> NewValue) -> ResultPredicate<NewValue> {
        return .init(self.value |> transform, description: self.description)
    }
}

public func beResult<Value, Error>(
    success: ResultPredicate<(Value) -> Bool>,
    failure: ResultPredicate<(Error) -> Bool>
)
    -> Predicate<Result<Value, Error>>
{
    return Predicate.define { expression in
        let value = (try? expression.evaluate()).flatten()
        let result: ResultPredicate<Bool> = call {
            switch value {
            case .success(let value)?: return success.map { $0 § value }
            case .failure(let error)?: return failure.map { $0 § error }
            default: return ResultPredicate(false, description: "unexpected")
            }
        }
        
        
        return PredicateResult(bool: result.value, message: .expectedTo(result.description))
    }
}

fileprivate func predicateIgnoringValue<Value>(_ value: Bool, description: String = "") -> ResultPredicate<(Value) -> Bool> {
    return ResultPredicate(ignoreInput { value }, description: description)
}

public func beSuccess<Value, Error>(_ predicate: @escaping (Value) -> Bool, description: String) -> Predicate<Result<Value, Error>> {
    return beResult(
        success: ResultPredicate(predicate, description: description),
        failure: predicateIgnoringValue(false, description: description)
    )
}

public func beSuccess<Value, Error>() -> Predicate<Result<Value, Error>> {
    return beSuccess(ignoreInput { true }, description: "be .success")
}

public func beSuccess<Value: Equatable, Error>(value: Value) -> Predicate<Result<Value, Error>> {
    return beSuccess({ value == $0 }, description: "be .success(\(value))")
}

public func beFailure<Value, Error>(_ predicate: @escaping (Error) -> Bool, description: String) -> Predicate<Result<Value, Error>> {
    return beResult(
        success: predicateIgnoringValue(false, description: description),
        failure: ResultPredicate(predicate, description: description)
    )
}

public func beFailure<Value, Error>() -> Predicate<Result<Value, Error>> {
    return beFailure(ignoreInput { false }, description: "be .failure")
}

public func beFailure<Value, Error: Equatable>(error: Error) -> Predicate<Result<Value, Error>> {
    return beFailure({ error == $0 }, description: "be .failure(\(error))")
}
