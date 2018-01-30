//
//  CallSpy.swift
//  FriendsInFaceBookTests
//
//  Created by Viktoria on 1/25/18.
//  Copyright © 2018 Victoria Kravets. All rights reserved.
//

import Foundation

@testable import FriendsInFaceBook

public class CallSpy<Argument, Result> {
    
    // MARK: -
    // MARK: Properties
    
    var isCalled: Bool {
         return self.callCount > 0
    }
    var callCount: Int {
        return self.arguments.count
    }
    var factory: (Argument) -> Result{
        didSet{
            self.reset()
        }
    }
    public private(set) var arguments = [Argument]()
    
    // MARK: -
    // MARK: Init and Deinit
    
    public init( _ factory: @escaping (Argument) -> Result) {
        self.factory = factory
    }
    
    // MARK: -
    // MARK: Public
    
    public func call(_ argument: Argument) -> Result {
        self.arguments.append(argument)
        return self.factory(argument)
    }
    public func reset(){
        self.arguments = []
    }
}

extension CallSpy where  Result == Void {
    
    // MARK: -
    // MARK: Init and Deinit
    
    public convenience init() {
        self.init( ignoreInput § returnValue § ())
    }
}

extension CallSpy where  Argument == Void {
    
    // MARK: -
    // MARK: Public
    
    func call() {
        self.arguments.append(())
    }
}
