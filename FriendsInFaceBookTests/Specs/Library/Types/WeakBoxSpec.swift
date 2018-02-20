//
//  WeakBoxSpec.swift
//  FriendsInFaceBookTests
//
//  Created by Admin on 18.02.2018.
//  Copyright © 2018 Victoria Kravets. All rights reserved.
//

import Foundation
import Quick
import Nimble

@testable import FriendsInFaceBook

class WeakBoxSpec: QuickSpec {
    override func spec() {
        describe("WeakBoxSpec") {
            context("when object is nil") {
                it("should pass and weak reference should be nil") {
                    var user: RealmUser? = RealmUser()
                    let weakRealmUser = WeakBox(user)
                    user = nil
                    expect(weakRealmUser.wrapped).to(beNil())
                }
            }
        }
    }
}
