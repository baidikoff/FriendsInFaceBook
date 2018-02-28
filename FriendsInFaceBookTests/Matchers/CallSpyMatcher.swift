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

public func beCalled<Argument: Equatable>() -> Predicate<CallSpy<Argument, Void>> {
    return Predicate.define { expression in
        let value = (try? expression.evaluate()).flatten()
        let result = value.map { $0.arguments.count > 0 } ?? false
        return PredicateResult(bool: result, message: .expectedTo(result.description))
    }
}

public func beCalled<Argument: Equatable>(at count: Int)  -> Predicate<CallSpy<Argument, Void>> {
    return Predicate.define { expression in
        let value = (try? expression.evaluate()).flatten()
        let result = value.map { $0.arguments.count == count } ?? false
        return PredicateResult(bool: result, message: .expectedTo(result.description))
    }
}

public func beCalledAtLeast<Argument: Equatable>(_ count: Int) -> Predicate<CallSpy<Argument, Void>> {
    return Predicate.define { expression in
        let value = (try? expression.evaluate()).flatten()
        let result = value.map { $0.arguments.count >= count } ?? false
        return PredicateResult(bool: result, message: .expectedTo(result.description))
    }
}

public func beCalledAtMost<Argument: Equatable>(_ count: Int) -> Predicate<CallSpy<Argument, Void>> {
    return Predicate.define { expression in
        let value = (try? expression.evaluate()).flatten()
        let result = value.map { $0.arguments.count <= count } ?? false
        return PredicateResult(bool: result, message: .expectedTo(result.description))
    }
}

public func beCalled<Argument: Equatable>(argument: Argument) -> Predicate<CallSpy<Argument, Void>> {
    return Predicate.define { expression in
        let value = (try? expression.evaluate()).flatten()
        let result = value.map { $0.arguments[0] == argument } ?? false
        return PredicateResult(bool: result, message: .expectedTo(result.description))
    }
}

public func beCalled<Argument: Equatable>(with arguments: [Argument]) -> Predicate<CallSpy<[Argument], Void>> {
    return Predicate.define { expression in
        let value = (try? expression.evaluate()).flatten()
        let result = value.map { $0.arguments[0] == arguments } ?? false
        return PredicateResult(bool: result, message: .expectedTo(""))
    }
}


// MATCHERS:
//func called()
//func called(count:)
//func calledAtLeast(_ count:)
//func calledAtMost(_ count:)
//func called(_ arguments:[Argument])
//func called(_ argument:Argument)
