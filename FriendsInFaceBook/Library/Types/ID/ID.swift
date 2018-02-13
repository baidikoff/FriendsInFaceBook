//
//  ID.swift
//  FriendsInFaceBook
//
//  Created by Oleksa 'trimm' Korin on 2/13/18.
//  Copyright © 2018 Victoria Kravets. All rights reserved.
//

import Foundation

public struct ID {
    
    // MARK: -
    // MARK: Properties
    
    public let value: Int
    
    // MARK: -
    // MARK: Init and Deinit
    
    public init(_ value: Int) {
        self.value = value
    }
    
    public init?(string: String) {
        guard
            let value = Int(string)
        else {
            return nil
        }
        
        self.init(value)
    }
}

extension ID: Comparable {
    
    public static func <(lhs: ID, rhs: ID) -> Bool {
        return lhs.value < rhs.value
    }
    
    public static func ==(lhs: ID, rhs: ID) -> Bool {
        return lhs.value == rhs.value
    }
}

extension ID: Hashable {
    
    public var hashValue: Int {
        return self.value.hashValue
    }
}

extension ID: CustomStringConvertible {
    
    public var description: String {
        return self.value.description
    }
}

extension ID: ExpressibleByIntegerLiteral {
    
    public init(integerLiteral value: Int) {
        self.init(value)
    }
}
