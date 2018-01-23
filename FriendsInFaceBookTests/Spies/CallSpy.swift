//
//  CallSpy.swift
//  FriendsInFaceBookTests
//
//  Created by Oleksa 'trimm' Korin on 1/23/18.
//  Copyright © 2018 Victoria Kravets. All rights reserved.
//

import Foundation

@testable import FriendsInFaceBook

public class CallSpy<Argument, Result> {
    
    // MARK: -
    // MARK: Subtypes
    
    public typealias ResultFactory = (Argument) -> Result
    
    // MARK: -
    // MARK: Property
    
    public fileprivate(set) var arguments = [Argument]()
    
    public var callCount: Int {
        return self.arguments.count
    }
    
    public var isCalled: Bool {
        return self.callCount > 0
    }
    
    public var resultFactory: ResultFactory {
        didSet { self.reset() }
    }
    
    // MARK: -
    // MARK: Init and Deinit
    
    public init(_ factory: @escaping ResultFactory) {
        self.resultFactory = factory
    }
    
    // MARK: -
    // MARK: Public
    
    public func call(_ argument: Argument) -> Result {
        self.arguments.append(argument)
        
        return self.resultFactory(argument)
    }
    
    public func reset() {
        self.arguments = []
    }
}

extension CallSpy where Result == Void {
    
    // MARK: -
    // MARK: Init and Deinit
    
    public convenience init() {
        self.init(ignoreInput § returnValue § ())
    }
}

extension CallSpy where Argument == Void {

    // MARK: -
    // MARK: Public
    
    public func call() {
        self.arguments.append(())
    }
}

// MATCHERS:
//func called()
//func called(count:)
//func calledAtLeast(_ count:)
//func calledAtMost(_ count:)
//func called(_ arguments:[Argument])
//func called(_ argument:Argument)
