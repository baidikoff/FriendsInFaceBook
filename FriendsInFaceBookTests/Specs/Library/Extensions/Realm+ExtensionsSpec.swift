//
//  Realm+ExtensionsSpec.swift
//  FriendsInFaceBookTests
//
//  Created by Oleksa 'trimm' Korin on 2/13/18.
//  Copyright © 2018 Victoria Kravets. All rights reserved.
//

import Quick
import Nimble

import RealmSwift

@testable import FriendsInFaceBook

class RealmObjectMock: Object {
    @objc open override class func primaryKey() -> String? {
        return "id"
    }
    
    @objc dynamic var id = ""
}

class RealmExtensionsSpec: QuickSpec {
    override func spec() {
        describe("Realm+Extensions") {
            beforeEach {
                Realm.write { $0.deleteAll() }
            }
            
            context("when performin recursive writes") {
                it("should succeed") {
                    expect {
                            Realm.write { realm in
                                let mock = RealmObjectMock()
                                mock.id = "0"
                                Realm.write { realm in
                                    let mock = RealmObjectMock()
                                    mock.id = "1"
                                }
                            }
                        }
                        .toNot(throwError())
                }
            }
        }
    }
}

