//
//  User.swift
//  FriendsInFaceBook
//
//  Created by Admin on 20.02.2018.
//  Copyright © 2018 Victoria Kravets. All rights reserved.
//

import Foundation
import RealmSwift

class User: Model<RLMUser> {
    
    // MARK: -
    // MARK: Open
    
    public var name: String? {
        didSet {
            self.write()
        }
    }
    
    public var age: Int? {
        didSet {
            self.write()
        }
    }
    
    // MARK: -
    // MARK: Open
    
    open override func readStorage(_ storage: StorageType) {
       self.name = storage.name
        self.age = storage.age
    }
    
    open override func writeStorage(_ storage: StorageType) {
        storage.name = self.name

    }

}
