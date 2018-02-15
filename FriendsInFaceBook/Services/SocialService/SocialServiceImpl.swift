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
    
    // MARK: -
    // MARK: Init and Deinit
    
    public init(_ facebookApi: FacebookApi) {
        self.facebookApi = facebookApi
    }
    
    // MARK: -
    // MARK: Public
    
    public func requestUsers(_ completion: @escaping ([User]) -> ()) -> ServiceTask {
        self.facebookApi.requestUsers { result in
            let resultUsers = result.value.flatten()
            let users:[String: Any]? =  resultUsers.flatMap(cast)
            users.do{
                let resultUsers = Mapper<Friends>().map(JSON:$0)
                resultUsers?.friends.do(completion)
            }
        }
        return ServiceTask(self.facebookApi)
    }
    
    public func logoutUser() -> ServiceTask {
        self.facebookApi.logout()
        return ServiceTask(self.facebookApi)
    }
    
    public func loginUser() -> ServiceTask {
        self.facebookApi.login()
        return ServiceTask(self.facebookApi)
    }    
}

