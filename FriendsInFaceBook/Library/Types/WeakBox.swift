//
//  WeakBox.swift
//  FriendsInFaceBook
//
//  Created by Oleksa 'trimm' Korin on 2/13/18.
//  Copyright © 2018 Victoria Kravets. All rights reserved.
//

import Foundation

public struct WeakBox<Wrapped: AnyObject> {
    
    // MARK: -
    // MARK: Properties
    
    public var isEmpty: Bool {
        return self.wrapped == nil
    }
    
    public private(set) weak var wrapped: Wrapped?
    
    // MARK: -
    // MARK: Init and Deinit
    
    public init(_ wrapped: Wrapped?) {
        self.wrapped = wrapped
    }
}

extension WeakBox: Equatable {
    
    public static func == (lhs: WeakBox, rhs: WeakBox) -> Bool {
        return lhs
            .wrapped.flatMap { lhs in
                rhs.wrapped.map { $0 === lhs }
            }
            ?? false
    }
    
}
