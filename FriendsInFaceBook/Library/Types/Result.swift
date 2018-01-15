//
//  Result.swift
//  FriendsInFaceBook
//
//  Created by Oleksa 'trimm' Korin on 12/20/17.
//  Copyright © 2017 Victoria Kravets. All rights reserved.
//

import Foundation

public enum NoError: Error { }

public func lift<Value, Error: Swift.Error>(_ value: Value) -> Result<Value, Error> {
    return .success(value)
}

public func lift<Value, Error: Swift.Error>(_ error: Error) -> Result<Value, Error> {
    return .failure(error)
}

public enum Result<Value, Error: Swift.Error> {
    
    // MARK: -
    // MARK: Cases
    
    case success(Value)
    case failure(Error)
    
    // MARK: -
    // MARK: Static
    
    private static func materialize(value: Value?, error: Error?, `default`: Error) -> Result {
        switch (value, error) {
        case let (_, error?): return .failure(error)
        case let (value?, nil): return .success(value)
        default: return .failure(`default`)
        }
    }
    
    // MARK: -
    // MARK: Properties
    
    public var value: Value? {
        return self.optional § self.analysis
    }
    
    public var error: Error? {
        return self.optional § flip § self.analysis
    }
    
    // MARK: -
    // MARK: Init and Deinit
    
    public init(value: Value?, error: Error?, `default`: Error) {
        self = .materialize(value: value, error: error, default: `default`)
    }
    
    // MARK: -
    // MARK: Public
    
    public func analysis<ReturnType>(success: (Value) -> ReturnType, failure: (Error) -> ReturnType) -> ReturnType {
        switch self {
        case let .success(wrapped): return success(wrapped)
        case let .failure(wrapped): return failure(wrapped)
        }
    }
    
    public func bimap<NewValue, NewError>(success: (Value) -> NewValue, failure: (Error) -> NewError) -> Result<NewValue, NewError> {
        return withoutActuallyEscaping(success) { success in
            withoutActuallyEscaping(failure) { failure in
                self.analysis(success: success • lift, failure: failure • lift)
            }
        }
    }
    
    public func map<NewValue>(_ transform: (Value) -> NewValue) -> Result<NewValue, Error> {
        return self.bimap(success: transform, failure: identity)
    }
    
    public func mapError<NewError>(_ transform: (Error) -> NewError) -> Result<Value, NewError> {
        return self.bimap(success: identity, failure: transform)
    }
    
    public func biflatMap(success: (Value) -> Result, failure: (Error) -> Result) -> Result {
        return self.analysis(success: success, failure: failure)
    }
    
    public func flatMap(_ transform: (Value) -> Result) -> Result {
        return self.biflatMap(success: transform, failure: lift)
    }
    
    public func flatMapError(_ transform: (Error) -> Result) -> Result {
        return self.biflatMap(success: lift, failure: transform)
    }
    
    // MARK: -
    // MARK: Private
    
    private func optional<Ignored, Result>(_ f: ((Result) -> Result?, (Ignored) -> Result?) -> Result?) -> Result? {
        return f(identity, ignoreInput § returnValue § nil)
    }
}

