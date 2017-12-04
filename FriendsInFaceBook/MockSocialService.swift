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
    func requestUsers() -> Promise<Array<User>> {
        return Promise<Array<User>>{ fulfill,_ in
            var users = [User]()
            let user1 = User(name: "Ivan Ivanov", imageUrl: "https://pbs.twimg.com/profile_images/437015947/Camel_Jordanian_Desert_400x400.jpg")
            users.append(user1)
            let user2 = User(name: "Vasiliy Vasichkin", imageUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQc3y2SzpwIZ1COygocjVLdfMX1lsmdyZ381zABwFNpJu42hIk4")
            users.append(user2)
            fulfill(users)
        }
    }
    
    func loginUser() {
        
    }
    
    func logoutUser() {
        
    }
    
    
}
