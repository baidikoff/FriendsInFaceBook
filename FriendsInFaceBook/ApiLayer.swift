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

class ApiLayer{
    
    let urlHost = "https://graph.facebook.com/v2.11/me/accounts?access_token="
    
    func getTokenFromFacebook() -> String? {
        return FBSDKAccessToken.current().tokenString
    }
        
}

