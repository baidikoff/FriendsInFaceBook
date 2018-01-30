//
//  ArrayMatchers.swift
//  FriendsInFaceBookTests
//
//  Created by Viktoria on 1/30/18.
//  Copyright © 2018 Victoria Kravets. All rights reserved.
//

import Quick
import Nimble

@testable import FriendsInFaceBook

public func equal<A: Equatable>(_ expected: [A])
    -> Predicate<[A]>
{
    return Predicate.define { expression in
        let value = (try? expression.evaluate()).flatten()
        let result = value.map { $0 == expected } ?? false
        return PredicateResult(bool: result, message: .expectedTo(result.description))
    }
}
