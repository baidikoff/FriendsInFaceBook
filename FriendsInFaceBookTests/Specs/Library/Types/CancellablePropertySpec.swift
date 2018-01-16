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

class CancellablePropertySpec: QuickSpec {
    override func spec() {
        let property = CancellableProperty()
        let value: Cancellable = MessageCaller(message: "method cancel is called")
        property.value = value
        describe("CancellableProperty") {
            it("it should be false becouse method cansel isn't called yet") {
                expect(property.value?.isCancelled).to(beFalse())
            }
            
            it("it should be true when method cancel is called") {
                value.cancel()
                expect(property.value?.isCancelled).to(beTrue())
            }
        }
    }
}
public class MessageCaller: Cancellable {
    
    // MARK: -
    // MARK: Properties
    
    public private(set) var isCancelled: Bool = false
    
    private var message: String
    
    // MARK: -
    // MARK: Init and Deinit
    
    public init(message: String) {
        self.message = message
    }
    
    // MARK: -
    // MARK: Public
    
    public func cancel() {
        print(self.message)
        self.isCancelled = true
    }
}
