//
//  User.swift
//  FriendsInFaceBook
//
//  Created by Admin on 20.02.2018.
//  Copyright © 2018 Victoria Kravets. All rights reserved.
//

import Foundation
import RealmSwift

public protocol User: UserStorage, Modelable {
    var didChange: (() -> ())? { get set }
}

public protocol UserStorage: class {
    var name: String? { get set }
    var age: Int? { get set }
}

public class UserImpl<Persistence: Persistable>: Model<Persistence>, User where Persistence.Storage: UserStorage {
    
    // MARK: -
    // MARK: Properties
    
    public var name: String? {
        didSet { self.write() }
    }
    
    public var age: Int? {
        didSet { self.write() }
    }
    
    public var didChange: (() -> ())?
    
    // MARK: -
    // MARK: Open
    
    open override func write() {
        super.write()
        
        self.didChange?()
    }
    
    open override func readStorage(_ storage: StorageType) {
        let persistence = self.persistence
        
        persistence.read(storage.name, to: &self.name)
        persistence.read(storage.age, to: &self.age)
    }
    
    open override func writeStorage(_ storage: StorageType) {
        let persistence = self.persistence
        
        persistence.write(self.name, to: &storage.name)
        persistence.write(self.age, to: &storage.age)
    }
}
