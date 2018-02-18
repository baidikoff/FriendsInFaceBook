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

fileprivate let string = "Called"

 class CancellableMock: Cancellable {
    
    // MARK: -
    // MARK: Properties
    
    let isCancelledSpy = CallSpy<Bool, Void>()
    private(set) var isCancelled: Bool = false {
        didSet { self.isCancelledSpy.call(isCancelled) }
    }
    
    // MARK: -
    // MARK: Public
    
    let cancelSpy = CallSpy<String,Void>()

    func cancel() {
        self.cancelSpy.call(string)
    }
   
}

class CancellablePropertySpec: QuickSpec {
    override func spec() {
        let property = CancellableProperty()
        let value = CancellableMock()
        
        describe("CancellableProperty") {
            it("it should cancel when new value is set") {
                property.value = value
                print(value.cancelSpy.arguments.count)
                expect(value.cancelSpy).toNot(beCalled())
            }
            
            it("it should cancel when new value is set") {
                property.value = nil
                print(value.cancelSpy.arguments.count)
                expect(value.cancelSpy).to(beCalled())
            }

            it("it should cancel when new value is set") {
                property.value = value
                print(value.cancelSpy.arguments.count)
                expect(value.cancelSpy).to(beCalled(at: 1))
            }
            
            it("it should cancel when new value is set") {
                property.value = nil
                print(value.cancelSpy.arguments.count)
                expect(value.cancelSpy).to(beCalledAtLeast(1))
            }
            
            it("it should cancel when new value is set") {
                property.value = nil
                print(value.cancelSpy.arguments.count)
                expect(value.cancelSpy).to(beCalledAtMost(2))
            }

            it("it should cancel when new value is set") {
                property.value = nil
                expect(value.cancelSpy).to(beCalled(argument: string))
            }
        }
    }
}
