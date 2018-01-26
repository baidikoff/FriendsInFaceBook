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

 class CancellablePropertyMock: Cancellable {
    
    // MARK: -
    // MARK: Properties
    
    let isCancelledSpy = CallSpy<Bool, Void>()
    private(set) var isCancelled: Bool = false {
        didSet { self.isCancelledSpy.call(isCancelled) }
    }
    
    // MARK: -
    // MARK: Public
    
    let cancelSpy = CallSpy<Void,Void>()

    func cancel() {
        self.cancelSpy.call()
    }
   
}

class CancellablePropertySpec: QuickSpec {
    override func spec() {
        let property = CancellableProperty()
        let value = CancellablePropertyMock()
        
        describe("CancellableProperty") {
            it("it should not cancel when set") {
                property.value = value
                expect(value.cancelSpy.callCount).to(notBeCalled())
            }
            
            it("it should cancel when new value is set") {
                property.value = nil
                expect(value.cancelSpy.callCount).to(beCalled())
            }
            
            it("it should cancel when new value is set") {
                property.value = nil
                expect(value.cancelSpy.callCount).to(beCalled(at: 1))
            }
            
            it("it should cancel when new value is set") {
                property.value = nil
                expect(value.cancelSpy.callCount).to(beCalledAtLeast(1))
            }
            
            it("it should cancel when new value is set") {
                property.value = nil
                expect(value.cancelSpy.callCount).to(beCalledAtMost(3))
            }
            
            it("it should cancel when new value is set") {
                property.value = nil
                let expectedArgument = String(describing: ())
                let argument = String(describing: value.cancelSpy.arguments[0])
                expect(argument).to(beCalled(argument: expectedArgument))
            }
            
            it("it should cancel when new value is set") {
                property.value = nil
                let expectedArguments = String(describing: [()])
                let arguments = String(describing: value.cancelSpy.arguments)
                expect(arguments).to(beCalled(argument: expectedArguments))
            }
        }
    }
}

