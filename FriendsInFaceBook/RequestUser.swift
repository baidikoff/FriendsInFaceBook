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

class RequestUsers{
    func getTokenFromFacebook() -> String{
        return FBSDKAccessToken.current().description
    }
        
}

