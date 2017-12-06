//
//  Optional+Extensions.swift
//  FriendsInFaceBook
//
//  Created by Oleksa 'trimm' Korin on 12/5/17.
//  Copyright © 2017 Victoria Kravets. All rights reserved.
//

public extension Optional {
    public func apply<Result>(_ transform: ((Wrapped) -> Result)?) -> Result? {
        return self.flatMap { value in
            transform.map { $0(value) }
        }
    }

//    public func apply<Value, Result>(_ value: Value?) -> Result?
//        where Wrapped == (Value) -> Result
//    {
//        return value.apply(self)
//    }
    
    public func flatten<Result>() -> Result?
        where Wrapped == Result?
    {
        return self.flatMap { $0 }
    }
    
    public func `do`(_ action: (Wrapped) -> ()) {
        self.map(action)
    }
}

//func map<Value, Result>(_ value: Value?, _ transform: (Value) -> Result) -> Result? {
//    switch value {
//    case let .some(value): return transform(value)
//    case .none: return nil
//    }
//}
//
//struct User {
//    let age: Int
//
//    func mapAge(_ transform: (Int) -> Int) -> User {
//        return User(age: transform(self.age))
//    }
//
//    func flatMapAge(_ transform: (Int) -> User) -> User {
//        return transform(self.age)
//    }
//}
//
////func map<Value, Result>(_ value: [Value], _ transform: (Value) -> Result) -> [Result]
////func map<Value, Result>(_ value: Promise<Value>, _ transform: (Value) -> Result) -> Promise<Result>
//
//precedencegroup CompositionPrecedence {
//    associativity: left
//    higherThan: AssignmentPrecedence
//}
//
//infix operator •: CompositionPrecedence
//
//func compose<A, B, C>(_ f: @escaping (A) -> B, _ g: @escaping (B) -> C) -> (A) -> C {
//    return { g(f($0)) }
//}
//
//func •<A, B, C>(_ f: @escaping (A) -> B, _ g: @escaping (B) -> C) -> (A) -> C {
//    return compose(f, g)
//}
//
//let value: Int? = 2
//let result = map(value) { Optional.some("\($0)") }
//
//let xs = [1, 2, 3, 4, 5]
//let ys = xs.map( { $0 * 2 } • { $0 % 3 } • { $0.description } )
//
//func flatMap<Value, Result>(_ value: Value?, _ transform: (Value) -> Result?) -> Result? {
//    switch value {
//    case let .some(value): return flatten(x.map(transform))
//    case .none: return nil
//    }
//}
//
//precedencegroup MonadCompositionPrecedence {
//    associativity: left
//    higherThan: DefaultPrecedence
//}
//
//infix operator >>->>: MonadCompositionPrecedence
//
//func mcompose<A, B, C>(_ f: @escaping (A) -> B?, _ g: @escaping (B) -> C?) -> (A) -> C? {
//    return { f($0).flatMap(g) }
//}
//
//func >>->><A, B, C>(_ f: @escaping (A) -> B?, _ g: @escaping (B) -> C?) -> (A) -> C? {
//    return mcompose(f, g)
//}
//
//let mtransform: (Int) -> [String] = { [$0 * 2] } >>->> { [$0 % 3] } >>->> { [$0.description] }
//let mys = xs.flatMap(mtransform)
//
//func apply<Value, Result>(_ value: Value?, _ transform: ((Value) -> Result)?) -> Result? {
//    return value.flatMap { x in
//        transform.map { $0(x) }
//    }
//}
//
//precedencegroup ApplicativeCompositionPrecedence {
//    associativity: left
//    higherThan: DefaultPrecedence
//}
//
//infix operator >>>: ApplicativeCompositionPrecedence
//
//func apcompose<A, B, C>(_ f: @escaping (A) -> B, _ g: @escaping ((B) -> C)?) -> (A) -> C? {
//    return {
//        f($0).flatMap { x in
//            g.map { $0(x) }
//        }
//    }
//}
//
//func >>><A, B, C>(_ f: @escaping (A) -> B, _ g: @escaping ((B) -> C)?) -> (A) -> C? {
//    return apcompose(f, g)
//}
//
//let `self`: Int? = 1
//let function: ((Int) -> String)? = { $0.description }
//let optionalfunction: ((Int) -> String?)? = { $0.description }
//
//var result: String? = nil
//
//if
//    let `self` = self,
//    let function = function
//{
//    result = function(self)
//}
//
//result = apply(self, function)
//let resultDoubleOptional = apply(self, optionalfunction)
//
//func flatten<Value>(_ x: Value??) -> Value? {
//    return x.flatMap { $0 }
//}
//
//let resultOptional = flatten(apply(self, optionalfunction))

