//
//  Realm+Extensions.swift
//  FriendsInFaceBook
//
//  Created by Oleksa 'trimm' Korin on 2/13/18.
//  Copyright © 2018 Victoria Kravets. All rights reserved.
//

import Foundation

import RealmSwift

public extension Realm {
    
    // MARK: -
    // MARK: Subtypes
    
    private struct Key {
        static let realm = "com.realm.thread.key"
    }
    
    // MARK: -
    // MARK: Static
    
    public static var current: Realm? {
        let key = Key.realm
        let thread = Thread.current
        
        return thread.threadDictionary[key]
            .flatMap { $0 as? WeakBox<Realm> }
            .flatMap { $0.wrapped }
            ?? call {
                (try? Realm()).map(
                    sideEffect { thread.threadDictionary[key] = WeakBox($0) }
                )
            }
    }
    
    public static func write(action: (Realm) -> ()) {
        self.current.do { realm in
            if realm.isInWriteTransaction {
                action(realm)
            } else {
                try? realm.write { action(realm) }
            }
        }
    }
}
