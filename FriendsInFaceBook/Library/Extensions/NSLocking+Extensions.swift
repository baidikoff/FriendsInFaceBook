//
//  NSLocking+Extensions.swift
//  FriendsInFaceBook
//
//  Created by Oleksa 'trimm' Korin on 12/20/17.
//  Copyright © 2017 Victoria Kravets. All rights reserved.
//

import Foundation

//let lock = NSLock()
//var int = 1
//
//let async: (@escaping @convention(block) () -> Swift.Void) -> () = {
//    DispatchQueue.global(qos: .background).async(execute: $0)
//}
//
//let incrementInt = { int = int + 1 }
//
//// t1: int = 1 -> 1 + 2 -> write int
//// t2: int = 1 -> 1 + 2 -> write int
//
//let threadSafeIncrementInt = {
//    lock.do {
//        incrementInt()
//    }
//}
//
//// t1: lock -> int = 1 -> 1 + 2 -> write int -> unlock -> wake t2
//// t2: wait t1 -> int = 1 -> 1 + 2 -> write int
//
//let recursiveLock = NSRecursiveLock()
//
//let recursiveThreadSafeIncrementInt = {
//    recursiveLock.do {
//        recursiveLock.do {
//            incrementInt()
//        }
//    }
//}

public extension NSLocking {
    
    public func `do`<Result>(action: () -> Result) -> Result {
        self.lock()
        defer { self.unlock() }
        
        return action()
    }
}
