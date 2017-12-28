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

    open func requestUsers() -> Promise<[User]>{
        return Promise<[User]>{ fulfill, reject in
            FBSDKGraphRequest(graphPath: UrlType.graphPath.rawValue, parameters: [UrlType.parametersKey.rawValue: UrlType.parametersValue.rawValue]).start{ connection, users, error -> Void in
                let testMode = ProcessInfo.processInfo.arguments.contains(Constants.testMode)
                if testMode{
                    fulfill(Constants.users)
                }
                error.do(reject)
                let users:[String: Any]? = users.flatMap(cast)
                users.do{
                    let resultUsers = Mapper<Friends>().map(JSON:$0)
                    resultUsers?.friends.do(fulfill)
                }
            }
        }
    }
    
    open func logoutUser(){
        let loginManager = FBSDKLoginManager()
        loginManager.logOut()
    }
    
    open func loginUser(completion: @escaping () -> ()){
        let loginManager = FBSDKLoginManager()
        loginManager.loginBehavior = FBSDKLoginBehavior.systemAccount
        loginManager.logIn(withReadPermissions: [Constants.publicProfile, Constants.email, Constants.userFriends], handler: { result, error in
            error.do({print("Error: ", $0)})
            result.do{_ in completion()}
        })
    }    
}

