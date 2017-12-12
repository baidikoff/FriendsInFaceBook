//
//  MockSocialService.swift
//  FriendsInFaceBook
//
//  Created by Viktoria on 12/4/17.
//  Copyright © 2017 Victoria Kravets. All rights reserved.
//

import Foundation
import PromiseKit

class MockSocialService: SocialService{
    
    // MARK: -
    // MARK: Open
    
    open func requestUsers() -> Promise<[User]> {
        return Promise<[User]>{ fulfill,_ in 
            fulfill(Constants.users)
        }
    }
}
