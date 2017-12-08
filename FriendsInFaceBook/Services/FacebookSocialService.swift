//
//  RequestUser.swift
//  FriendsInFaceBook
//
//  Created by Viktoria on 12/1/17.
//  Copyright © 2017 Victoria Kravets. All rights reserved.
//

import Foundation
import FBSDKCoreKit
import FBSDKLoginKit
import ObjectMapper
import PromiseKit

class FacebookSocialService: SocialService{

    static let shared = FacebookSocialService()
    
    // MARK: -
    // MARK: Open
    
    open func alreadyLoggedIn() -> Bool {
        return (FBSDKAccessToken.current() != nil)
    }

    open func requestUsers() -> Promise<Array<User>>{
        return Promise<Array<User>>{ fulfill, reject in
            FBSDKGraphRequest(graphPath: UrlType.graphPath.rawValue, parameters: [UrlType.parametersKey.rawValue: UrlType.parametersValue.rawValue]).start{ connection, users, error -> Void in
                let testMode = ProcessInfo.processInfo.arguments.contains("testMode")
                if testMode{
                    fulfill(MockSocialService.users)
                }
                error.do(reject)
                let users:[String: Any]? = users.flatMap(cast)
                users.do{ users in
                    let resultUsers = Mapper<Friends>().map(JSON:users)
                    resultUsers?.friends.do(fulfill)
                }
            }
        }
    }
    
    open func logoutUser(){
        let loginManager = FBSDKLoginManager()
        loginManager.logOut()
    }
    
    open func loginUser(){
        let loginManager = FBSDKLoginManager()
        loginManager.loginBehavior = FBSDKLoginBehavior.systemAccount
        loginManager.logIn(withReadPermissions: ["public_profile", "email", "user_friends"], handler: { result, error in
            result.do({_ in print("Log in successfully")})
        })
    }
    
}

