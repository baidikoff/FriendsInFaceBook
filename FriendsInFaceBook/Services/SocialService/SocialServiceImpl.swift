//
//  RequestUser.swift
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
    var users: [User]?
    
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
    
    public func requestUsers(_ completion: @escaping ([User]) -> ()) -> Cancellable {
        return self.lock.do {
            if isLoaded {
                self.facebookApi.users
                print(self.users)
                self.users.do(completion)
                return self.cancellable
            } else {
                self.facebookApi.requestUsers { result in
                    let resultUsers = result.value.flatten()
                    let users:[String: Any]? =  resultUsers.flatMap(cast)
                    users.do{
                        let resultUsers = Mapper<Friends>().map(JSON:$0)
                        self.users = resultUsers?.friends
                        print(self.users)
                        resultUsers.do {completion($0.friends) }
                    }
                }
                return self.cancellable
            }
        }
    }
    
    public func logoutUser() -> Cancellable {
        self.facebookApi.logout()
        return ServiceTask(self.facebookApi)
    }
    
    public func loginUser() -> Cancellable {
        self.facebookApi.login()
        return ServiceTask(self.facebookApi)
    }    
}

