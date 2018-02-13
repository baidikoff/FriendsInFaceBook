//
//  User.swift
//  FriendsInFaceBook
//
//  Created by Oleksa 'trimm' Korin on 2/13/18.
//  Copyright © 2018 Victoria Kravets. All rights reserved.
//

import Foundation

public class User: Model<RLMUser> {
    
    // MARK: -
    // MARK: Properties
    
    public var name: String? {
        didSet { self.write() }
    }
    
    public var age: Int? {
        didSet { self.write() }
    }
    
    // MARK: -
    // MARK: Open
    
    open override func writeStorage(_ storage: StorageType) {
        storage.name = self.name
        storage.age.value = self.age
    }
    
    open override func readStorage(_ storage: StorageType) {
        self.name = storage.name
        self.age = storage.age.value
    }
}
