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
    
    func alreadyLoggedIn() -> Bool {
        if FBSDKAccessToken.current() != nil{
            return true
        } else {
            return false
        }
    }
    
     func requestUsers() -> Promise<Array<User>>{
        return Promise<Array<User>>{ fulfill, reject in
            FBSDKGraphRequest(graphPath: "me/taggable_friends", parameters: [UrlType.parametersKey: UrlType.parametersValue]).start{ connection, users, error -> Void in
                if error != nil {
                    print("Error: ", error)
                    reject(error!)
                }
                if users != nil{
                    let object = Mapper<Friends>().map(JSON: users as! [String : Any])
                    let listOfFriends: Array<User> = (object?.friends)!
                    fulfill(listOfFriends)
                }
            }
        }
    }
    
     func logoutUser(){
        let loginManager = FBSDKLoginManager()
        loginManager.logOut()
    }
    
     func loginUser(){
        let loginManager = FBSDKLoginManager()
        loginManager.loginBehavior = FBSDKLoginBehavior.systemAccount
        loginManager.logIn(withReadPermissions: ["public_profile", "email", "user_friends"], handler: { result, error in
            if (error == nil){
                print("Log in successfully")
            }
        })
    }
    
}

