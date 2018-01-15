//
//  Functions.swift
//  FriendsInFaceBook
//
//  Created by Oleksa 'trimm' Korin on 12/5/17.
//  Copyright © 2017 Victoria Kravets. All rights reserved.
//

public func cast<Value, Result>(_ value: Value) -> Result? {
    return value as? Result
}

public func identity<Value>(_ value: Value) -> Value {
    return value
}

public func ignoreInput<Value, Result>(_ action: @escaping () -> Result) -> (Value) -> Result {
    return { _ in
        action()
    }
}

public func returnValue<Value>(_ value: Value) -> () -> Value {
    return { value }
}

public func curry<A, B, C>(_ f: @escaping (A, B) -> C) -> (A) -> (B) -> C {
    return { a in
        { f(a, $0) }
    }
}

public func uncurry<A, B, C>(_ f: @escaping (A) -> (B) -> C) -> (A, B) -> C {
    return { f($0)($1) }
}

public func flip<A, B, C>(_ f: @escaping (A) -> (B) -> C) -> (B) -> (A) -> C {
    return { b in
        { f($0)(b) }
    }
}

public func flip<A, B, C>(_ f: @escaping (A, B) -> C) -> (B, A) -> C {
    return { f($1, $0) }
}

public func scope(_ action: () -> ()) {
    action()
}

public func call<Value>(_ action: () -> Value) -> Value {
    return action()
}
