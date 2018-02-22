 //
//  Atomic.swift
//  FriendsInFaceBook
//
//  Created by Admin on 21.02.2018.
//  Copyright © 2018 Victoria Kravets. All rights reserved.
//

import Foundation

 public class Atomic<Value> {
    
    // MARK: -
    // MARK: Subtypes

    public typealias PropertyObserver = ((old: ValueType, new: ValueType)) -> ()
    
    public typealias ValueType = Value
    
    // MARK: -
    // MARK: Properties
 
    public var value: ValueType {
        get { return transform { $0 } }
        set { modify { $0 = newValue } }
    }
    
    public var mutableValue: ValueType
    public var didSet: PropertyObserver?
    
    private let lock: NSRecursiveLock
    
    // MARK: -
    // MARK: Init and Deinit
    
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
    
    public func modify<Result>(_ action: ( inout ValueType) -> Result) -> Result {
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
