//
//  RequestRealmUser.swift
//  FriendsInFaceBook
//
//  Created by Viktoria on 12/1/17.
//  Copyright © 2017 Victoria Kravets. All rights reserved.
//

import Foundation
import PromiseKit
import ObjectMapper

public class SocialServiceImpl: SocialService {
    
    // MARK: -
    // MARK: Properties
    
    let facebookApi: FacebookApi
    public var isAlreadyLoggedIn: Bool {
        return self.facebookApi.isAlreadyLoggedIn
    }
    var users: [RealmUser]?
    
    public var isLoaded: Bool {
        return self.facebookApi.users != nil
    }
    public var cancellable: Cancellable
    private var isLoading = false
    private let lock = NSRecursiveLock()
    
    // MARK: -
    // MARK: Init and Deinit
    
    public init(_ facebookApi: FacebookApi) {
        self.facebookApi = facebookApi
        self.cancellable = ServiceTask(facebookApi)
    }
    
    // MARK: -
    // MARK: Public
    
    public func requestRealmUsers(_ completion: @escaping ([RealmUser]) -> ()) -> Cancellable {
        return self.lock.do {
            if isLoaded {
                self.facebookApi.users
                self.users.do(completion)
                return self.cancellable
            } else {
                self.facebookApi.requestRealmUsers { result in
                    let resultRealmUsers = result.value.flatten()
                    let users:[String: Any]? =  resultRealmUsers.flatMap(cast)
                    users.do{
                        let resultRealmUsers = Mapper<Friends>().map(JSON:$0)
                        self.users = resultRealmUsers?.friends
                        resultRealmUsers.do {completion($0.friends) }
                    }
                }
                return self.cancellable
            }
        }
    }
    
    public func logoutRealmUser() -> Cancellable {
        self.facebookApi.logout()
        return ServiceTask(self.facebookApi)
    }
    
    public func loginRealmUser() -> Cancellable {
        self.facebookApi.login()
        return ServiceTask(self.facebookApi)
    }    
}

