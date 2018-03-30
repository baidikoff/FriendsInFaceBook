//
//  Realm+Extensions.swift
//  FriendsInFaceBook
//
//  Created by Admin on 18.02.2018.
//  Copyright © 2018 Victoria Kravets. All rights reserved.
//

import Foundation
import RealmSwift


public extension Realm {
    
    private struct Key {
        static let realm = "com.realm.thread"
    }
    
    public static var current: Realm? {
        let key = Key.realm
        let thread = Thread.current
        
        return thread.threadDictionary[key]
            .flatMap { $0 as? WeakBox<Realm> }
            .flatMap { $0.wrapped }
            ?? call {
                (try? Realm()).flatMap(
                    sideEffect { thread.threadDictionary[key] = WeakBox($0) }
                )
        }
    }
    
    public static func write(_ action: (Realm) -> ()) {
        self.current.do { $0.write(action) }
    }
    
    public func write(_ action: (Realm) -> ()) {
        if self.isInWriteTransaction{
            action(self)
        } else {
            try? self.write { action(self) }
        }
    }
}
