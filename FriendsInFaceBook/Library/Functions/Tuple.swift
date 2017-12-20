//
//  Tuple.swift
//  FriendsInFaceBook
//
//  Created by Oleksa 'trimm' Korin on 12/20/17.
//  Copyright © 2017 Victoria Kravets. All rights reserved.
//

public func lift<A, B>(_ tuple: (A?, B?)) -> (A, B)? {
    return tuple.0.flatMap { a in
        tuple.1.map { (a, $0) }
    }
}

public func lift<A, B>(_ a: A?, _ b: B?) -> (A, B)? {
    return lift((a, b))
}
