//
//  UserFactory.swift
//  FriendsInFaceBook
//
//  Created by Oleksa 'trimm' Korin on 3/30/18.
//  Copyright © 2018 Victoria Kravets. All rights reserved.
//

import Foundation

public protocol UserFactory {
    
    func user() -> User
    func user(id: ID) -> User
}

fileprivate let key = "com.friendsinfacebook.user.defaults.key"
fileprivate let idFactory = autoincrementedID(key: key)

extension UserFactory {
   
    // MARK: -
    // MARK: Public
    
    public func user() -> User {
        return self.user(id: idFactory())
    }
}

public class UserRealmFactory: UserFactory {
    
    // MARK: -
    // MARK: Public
    
    public func user(id: ID) -> User {
        return UserImpl(id: id, persistence: RealmPersistence<RLMUser>())
    }
}
