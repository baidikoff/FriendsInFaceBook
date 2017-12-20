//
//  Operators.swift
//  FriendsInFaceBook
//
//  Created by Oleksa 'trimm' Korin on 12/20/17.
//  Copyright © 2017 Victoria Kravets. All rights reserved.
//

infix operator •: CompositionPrecedence
func • <A, B, C>(f: @escaping (A) -> B, g: @escaping (B) -> C) -> (A) -> C {
    return { g(f($0)) }
}

infix operator |>: LeftFunctionApplicationPrecedence
public func |> <A, B>(value: A, f: (A) -> B) -> B {
    return f § value
}

infix operator §: RightFunctionApplicationPrecedence
public func § <A, B>(f: (A) -> B, value: A) -> B {
    return f(value)
}

infix operator <|: RightFunctionApplicationPrecedence
public func <| <A, B>(f: (A) -> B, value: A) -> B {
    return f § value
}
