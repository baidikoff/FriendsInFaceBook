//
//  CancellablePropertySpec.swift
//  FriendsInFaceBookTests
//
//  Created by Viktoria on 1/16/18.
//  Copyright © 2018 Victoria Kravets. All rights reserved.
//

import Quick
import Nimble

@testable import FriendsInFaceBook

fileprivate class CancellableMock: Cancellable {
    
    // MARK: -
    // MARK: Properties
    
    let isCancelledSpy = CallSpy<Bool, Void>()
    private(set) var isCancelled: Bool = false {
        didSet { self.isCancelledSpy.call(isCancelled) }
    }
    
    // MARK: -
    // MARK: Public
    
    let cancelSpy = CallSpy<Void, Void>()
    func cancel() {
        self.cancelSpy.call()
    }
}

class CancellablePropertySpec: QuickSpec {
    override func spec() {
        let property = CancellableProperty()
        let value = CancellableMock()
        
        describe("CancellableProperty") {
            context("value") {
                it("it should not cancel when set") {
                    property.value = value
                    expect(value.cancelSpy.isCalled).to(beFalse())
                }
                
                it("it should cancel when new value is set") {
                    property.value = nil
                    expect(value.cancelSpy.isCalled).to(beTrue())
                }
            }
        }
    }
}
