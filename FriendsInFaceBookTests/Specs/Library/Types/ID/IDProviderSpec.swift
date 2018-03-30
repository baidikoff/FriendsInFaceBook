//
//  IDProviderSpec.swift
//  FriendsInFaceBookTests
//
//  Created by Admin on 26.02.2018.
//  Copyright © 2018 Victoria Kravets. All rights reserved.
//

import Quick
import Nimble

@testable import FriendsInFaceBook

class IDProviderSpec: QuickSpec {
    override func spec() {
        describe("IDProviderSpec") {
            context("when using Nimble and Quick") {
                it("should pass") {
                    let modelIdProvider: IDProvider = autoincrementedID(6)
                    modelIdProvider()
                    modelIdProvider()
                    let id = modelIdProvider()
                    
                    expect(id).to(equal(8))
                }
                
                it("should pass") {
                    let modelIdProvider: IDProvider = autoincrementedID(key: "com.realm.model.key")
                    let id = modelIdProvider()
                    let result = id.value + 1
                    let lastID = modelIdProvider()
                    
                    expect(result).to(equal(lastID.value))
                }
            }
        }
    }
}
