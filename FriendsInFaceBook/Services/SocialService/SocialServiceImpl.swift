//
//  RequestUser.swift
//  FriendsInFaceBook
//
//  Created by Viktoria on 12/1/17.
//  Copyright © 2017 Victoria Kravets. All rights reserved.
//

import Foundation
import PromiseKit

public class SocialServiceImpl: SocialService {

    // MARK: -
    // MARK: Properties
    
    let facebookDelegate = FacebookApi()
    public var isAlreadyLoggedIn: Bool {
        return self.facebookDelegate.isAlreadyLoggedIn
    }

    // MARK: -
    // MARK: Public
    
    public func requestUsers(_ completion: @escaping ([RealmUser]) -> ()) -> ServiceTask {
        self.facebookDelegate.requestUsers{ users in
            completion(users)
        }
        return ServiceTask(request: self.facebookDelegate)
    }
    
    public func logoutUser(){
        self.facebookDelegate.logout()
    }
    
    public func loginUser(){
        self.facebookDelegate.login()
    }    
}

