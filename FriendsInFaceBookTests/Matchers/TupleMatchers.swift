//
//  TupleMatchers.swift
//  FriendsInFaceBookTests
//
//  Created by Viktoria on 1/15/18.
//  Copyright © 2018 Victoria Kravets. All rights reserved.
//

import Quick
import Nimble

@testable import FriendsInFaceBook

public func equal<A: Equatable, B: Equatable>(_ expected: (A, B)) -> Predicate<(A, B)> {
    return Predicate.define { expression in
        let value = (try? expression.evaluate()).flatten()
        let result = value.map { $0 == expected } ?? false
        
        return PredicateResult(bool: result, message: .expectedTo(result.description))
    }
}

public func equal<A: Equatable, B: Equatable, C: Equatable>(_ expected: (A, B, C)) -> Predicate<(A, B, C)> {
    return Predicate.define { expression in
        let value = (try? expression.evaluate()).flatten()
        let result = value.map { $0 == expected } ?? false
        
        return PredicateResult(bool: result, message: .expectedTo(result.description))
    }
}

