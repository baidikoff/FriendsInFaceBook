//
//  Persistence.swift
//  FriendsInFaceBook
//
//  Created by Oleksa 'trimm' Korin on 3/30/18.
//  Copyright © 2018 Victoria Kravets. All rights reserved.
//

import Foundation

public protocol Persistable {
    associatedtype Storage
    
    func read(id: ID) -> Storage
    func write(storage: Storage)
    
    func read<Value>(_ value: Value, to target: inout Value)
    func write<Value>(_ value: Value, to target: inout Value)
}
