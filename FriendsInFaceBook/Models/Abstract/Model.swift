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
    
    public static func instantiate(storage: StorageType?) -> Self? {
        return storage
            .flatMap { $0.id.split(separator: "_").first }
            .flatMap { ID(string: String($0)) }
            .map(self.init)
    }
    
    // MARK: -
    // MARK: Properties
    
    public let id: ID
    
    public var storageId: String {
        return "\(self.id)_\(typeString(self).lowercased())"
    }
    
    public var storage: StorageType {
        let id = self.storageId
        
        return Realm.current?.object(ofType: StorageType.self, forPrimaryKey: id)
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
    
    public required init(_ id: ID) {
        self.id = id
        
        self.configure()
    }
    
    public convenience init(_ id: Int) {
        self.init(ID(id))
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
