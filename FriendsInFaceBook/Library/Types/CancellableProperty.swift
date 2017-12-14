//
//  CancellableProperty.swift
//  FriendsInFaceBook
//
//  Created by Oleksa 'trimm' Korin on 12/14/17.
//  Copyright © 2017 Victoria Kravets. All rights reserved.
//

import Foundation

public protocol Cancellable {
    func cancel()
}

public class CancellableProperty {
    
    // MARK: -
    // MARK: Properties
    
    public var value: Cancellable? {
        willSet { value?.cancel() }
    }
    
}
