//
//  Atomic.swift
//  FriendsInFaceBook
//
//  Created by Oleksa 'trimm' Korin on 2/13/18.
//  Copyright © 2018 Victoria Kravets. All rights reserved.
//

import Foundation

public class Atomic<Value> {
    
    // MARK: -
    // MARK: Subtypes
    
    public typealias ValueType = Value
    public typealias PropertyObserver = ((old: Value, new: Value)) -> ()
    
    // MARK: -
    // MARK: Properties
    
    public var value: Value {
        get { return self.transform { $0 } }
        set { self.modify { $0 = newValue } }
    }
    
    private var mutableValue: Value
    
    private let lock: NSRecursiveLock
    private let didSet: PropertyObserver?
    
    // MARK: -
    // MARK: Init
    
    public init(
        _ value: ValueType,
        lock: NSRecursiveLock = NSRecursiveLock(),
        didSet: PropertyObserver? = nil
    ) {
        self.mutableValue = value
        self.lock = lock
        self.didSet = didSet
    }
    
    // MARK: -
    // MARK: Public
    
    @discardableResult
    public func modify<Result>(_ action: (inout ValueType) -> Result) -> Result {
        return self.lock.do {
            let oldValue = self.mutableValue
            
            defer {
                self.didSet?((oldValue, self.mutableValue))
            }
            
            return action(&self.mutableValue)
        }
    }
    
    public func transform<Result>(_ action: (ValueType) -> Result) -> Result {
        return self.lock.do { action(self.mutableValue) }
    }
}
