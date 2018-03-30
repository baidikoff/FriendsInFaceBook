//
//  RealmExtensionsSpec.swift
//  FriendsInFaceBookTests
//
//  Created by Admin on 19.02.2018.
//  Copyright © 2018 Victoria Kravets. All rights reserved.
//

import Quick
import Nimble
import RealmSwift

@testable import FriendsInFaceBook

class RealmExtensionMock: Object {
    @objc open override class func primaryKey() -> String? {
        return "id"
    }
    
    @objc dynamic var id = ""
}

class RealmExtensionsSpec: QuickSpec {
    override func spec() {
        describe("RealmExtensionsSpec") {
            context("when using Nimble and Quick") {
                beforeEach {
                    Realm.write { $0.deleteAll() }
                }
                
                it("should pass") {
                    expect {
                            Realm.write { realm in
                                let mock = RealmExtensionMock()
                                mock.id = "0"
                                Realm.write { realm in
                                    let mock = RealmExtensionMock()
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
