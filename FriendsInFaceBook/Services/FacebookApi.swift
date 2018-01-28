//
//  FacebookApi.swift
//  FriendsInFaceBook
//
//  Created by Viktoria on 1/28/18.
//  Copyright © 2018 Victoria Kravets. All rights reserved.
//

import Foundation
import FBSDKCoreKit
import FBSDKLoginKit
import PromiseKit
import ObjectMapper

class FacebookApi {
    
    var isAlreadyLoggedIn: Bool{
        return (FBSDKAccessToken.current() != nil)
    }
    
    var users: [User]? {
        return self.getUsers()
    }
    
    func getUsers() -> [User]{
        self.requestUsers().then { users in
            return users
        }
        return []
    }
    
    func login(){
        let loginManager = FBSDKLoginManager()
        loginManager.loginBehavior = FBSDKLoginBehavior.systemAccount
        loginManager.logIn(withReadPermissions: [Constants.publicProfile, Constants.email, Constants.userFriends], handler: { result, error in
            error.do({print("Error: ", $0)})
            result.do({print("Success ", $0)})
        })
    }
    
    func logout(){
        let loginManager = FBSDKLoginManager()
        loginManager.logOut()
    }
    
    func requestUsers() -> Promise<[User]>{
        return Promise<[User]>{ fulfill, reject in
            FBSDKGraphRequest(graphPath: UrlType.graphPath.rawValue, parameters: [UrlType.parametersKey.rawValue: UrlType.parametersValue.rawValue]).start{ connection, users, error -> Void in
                error.do(reject)
                let users:[String: Any]? = users.flatMap(cast)
                users.do{
                    let resultUsers = Mapper<Friends>().map(JSON:$0)
                    resultUsers?.friends.do(fulfill)
                }
            }
        }
    }
}
