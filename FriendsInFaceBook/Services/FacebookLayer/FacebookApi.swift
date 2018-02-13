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

public class FacebookApi {
    
    var isAlreadyLoggedIn: Bool{
        return (FBSDKAccessToken.current() != nil)
    }
    
    public var facebookRequest: FBSDKGraphRequestConnection?
    
    public func login(){
        let loginManager = FBSDKLoginManager()
        loginManager.loginBehavior = FBSDKLoginBehavior.systemAccount
        loginManager.logIn(withReadPermissions: [Constants.publicProfile, Constants.email, Constants.userFriends], handler: { result, error in
            error.do({print("Error: ", $0)})
            result.do({print("Success ", $0)})
        })
        
    }
    
    public func logout(){
        let loginManager = FBSDKLoginManager()
        loginManager.logOut()
    }
    
    func requestUsers(completion: @escaping ([RealmUser]) -> ()){
            self.facebookRequest = FBSDKGraphRequest(graphPath: UrlType.graphPath.rawValue, parameters: [UrlType.parametersKey.rawValue: UrlType.parametersValue.rawValue])
                .start{ connection, users, error -> Void in
               // error.do(reject)
                let users:[String: Any]? = users.flatMap(cast)
                users.do{
                    let resultUsers = Mapper<Friends>().map(JSON:$0)
                    resultUsers?.friends.do(completion)
                }
            }
    }
}
