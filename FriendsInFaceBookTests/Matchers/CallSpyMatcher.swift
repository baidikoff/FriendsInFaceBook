//
//  CallSpyMatcher.swift
//  FriendsInFaceBookTests
//
//  Created by Viktoria on 1/25/18.
//  Copyright © 2018 Victoria Kravets. All rights reserved.
//


import Quick
import Nimble

@testable import FriendsInFaceBook

public func beCalled()
    -> Predicate<Int>
{
    return Predicate.define { expression in
        let value = (try? expression.evaluate()).flatten()
        let result = value.map { $0 > 0 } ?? false
        return PredicateResult(bool: result, message: .expectedTo(result.description))
    }
}

public func beCalled(at count: Int)
    -> Predicate<Int>
{
    return Predicate.define { expression in
        let value = (try? expression.evaluate()).flatten()
        let result = value.map { $0 == count } ?? false
        return PredicateResult(bool: result, message: .expectedTo(result.description))
    }
}

public func beCalledAtLeast(_ count: Int)
    -> Predicate<Int>
{
    return Predicate.define { expression in
        let value = (try? expression.evaluate()).flatten()
        let result = value.map { $0 >= count } ?? false
        return PredicateResult(bool: result, message: .expectedTo(result.description))
    }
}

public func beCalledAtMost(_ count: Int)
    -> Predicate<Int>
{
    return Predicate.define { expression in
        let value = (try? expression.evaluate()).flatten()
        let result = value.map { $0 <= count } ?? false
        return PredicateResult(bool: result, message: .expectedTo(result.description))
    }
}

public func beCalled<Argument: Equatable>(with arguments: [Argument])
    -> Predicate<[Argument]>
{
    return Predicate.define { expression in
        let value = (try? expression.evaluate()).flatten()
        let result = value.map { $0 == arguments } ?? false
        return PredicateResult(bool: result, message: .expectedTo(result.description))
    }
}

public func beCalled<Argument: Equatable>(argument: Argument)
    -> Predicate<Argument>
{
    return Predicate.define { expression in
        let value = (try? expression.evaluate()).flatten()
        let result = value.map { $0 == argument } ?? false
        return PredicateResult(bool: result, message: .expectedTo(result.description))
    }
}

public func notBeCalled()
    -> Predicate<Int>
{
    return Predicate.define { expression in
        let value = (try? expression.evaluate()).flatten()
        let result = value.map { $0 == 0 } ?? false
        return PredicateResult(bool: result, message: .expectedTo(result.description))
    }
}

func ==(lhs: RealmUser, rhs: RealmUser) -> Bool {
    return lhs.name == rhs.name
}

// MATCHERS:
//func called()
//func called(count:)
//func calledAtLeast(_ count:)
//func calledAtMost(_ count:)
//func called(_ arguments:[Argument])
//func called(_ argument:Argument)
