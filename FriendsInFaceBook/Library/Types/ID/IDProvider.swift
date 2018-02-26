//
//  IDProvider.swift
//  FriendsInFaceBook
//
//  Created by Admin on 21.02.2018.
//  Copyright © 2018 Victoria Kravets. All rights reserved.
//

import Foundation

public typealias IDProvider = () -> ID

public func autoincrementedID(start: Int) -> IDProvider {
    return autoincrementedID(1)
}

fileprivate let persistentProviders = Atomic([String: IDProvider]())

public func autoincrementedID(key: String) -> IDProvider {
    return persistentProviders.modify { storage in
        storage[key] ?? call {
            let defaults = UserDefaults.standard
            
            let result = autoincrementedID(defaults.integer(forKey: key)) {
                defaults.set($0, forKey: key)
            }
            
            storage[key] = result
            
            return result
        }
    }
}

public func autoincrementedID(_ start: Int, action: ((Int) -> ())? = nil)  -> IDProvider {
    let value = Atomic(start)
    
    return {
        value.modify {
            let result = $0
            $0 += 1
            action?($0)
            return ID(result)
        }
    }
}
