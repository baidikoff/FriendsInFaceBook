//
//  Model.swift
//  FriendsInFaceBook
//
//  Created by Oleksa 'trimm' Korin on 2/13/18.
//  Copyright © 2018 Victoria Kravets. All rights reserved.
//

import Foundation

import RealmSwift

public class Model<Storage: RLMModel> {
    
    // MARK: -
    // MARK: Subtypes
    
    public typealias StorageType = Storage
    
    // MARK: -
    // MARK: Static
    
    public static func instantiate(storage: StorageType) -> Self {
        return self.init(id: storage.id)
    }
    
    // MARK: -
    // MARK: Properties
    
    public let id: String
    public var storage: StorageType {
        let id = self.id
        
        return Realm.current?.object(ofType: StorageType.self, forPrimaryKey: self.id)
            ?? modify(StorageType()) { storage in
                storage.id = id
                Realm.write { $0.add(storage, update: true) }
            }
    }
    
    private let lock: NSLocking = NSRecursiveLock()
    private var isInWriteTransaction = false
    private var isInReadTransaction = false
    
    // MARK: -
    // MARK: Init and Deinit
    
    public required init(id: String) {
        self.id = id
        
        self.configure()
    }
    
    // MARK: -
    // MARK: Public
    
    public func read() {
        self.performStorageTransaction(
            excluding: { self.isInWriteTransaction },
            condition: { self.isInReadTransaction = $0 },
            action: { self.readStorage(self.storage) }
        )
    }
    
    public func write() {
        self.update {
            self.writeStorage(self.storage)
        }
    }
    
    public func update(action: () -> ()) {
        self.performStorageTransaction(
            excluding: { self.isInReadTransaction },
            condition: { self.isInWriteTransaction = $0 },
            action: {
                Realm.write { _ in
                    action()
                }
            }
        )
    }
    
    // MARK: -
    // MARK: Open
    
    open func configure() {
        self.read()
    }
    
    open func writeStorage(_ storage: StorageType) {
        
    }
    
    open func readStorage(_ storage: StorageType) {
        
    }
    
    // MARK: -
    // MARK: Private
    
    private func locked(action: () -> ()) {
        self.lock.do(action: action)
    }
    
    private func performStorageTransaction(
        excluding: () -> Bool,
        condition: (Bool) -> (),
        action: () -> ()
    ) {
        self.locked {
            if excluding() {
                return
            }
            
            condition(true)
            action()
            condition(false)
        }
    }
}
