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

class ApiLayer{
    
    let urlHost = "https://graph.facebook.com/"
    let urlPath = "v2.11/me/accounts?access_token="
    func getTokenFromFacebook() -> String? {
        return FBSDKAccessToken.current().tokenString
    }
    init() {

    }
    func requestUsers() -> Promise<Array<User>>{
        return Promise<Array<User>>{ fulfill, reject in
            let parameters = ["fields": "name, picture.type(normal), gendar"]
            FBSDKGraphRequest(graphPath: "me/taggable_friends", parameters: parameters).start{ connection, users, error -> Void in
                if error != nil {
                    print("Error: ", error)
                    reject(error!)
                }
                if users != nil{
                    let object = Mapper<Friends>().map(JSON: users as! [String : Any])
                    let listOfFriends = object?.friends
                    fulfill(listOfFriends!)
                }
            }
        }
        }
        
        
}

