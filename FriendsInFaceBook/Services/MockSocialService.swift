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
    static let users = [User(name: "Ivan Ivanov"), User(name: "Vasiliy Vasichkin")]
    
    
    func requestUsers() -> Promise<Array<User>> {
        return Promise<Array<User>>{ fulfill,_ in 
            fulfill(MockSocialService.users)
        }
    }
    
    func loginUser() {
        
    }
    
    func logoutUser() {
        
    }
    
    
}
