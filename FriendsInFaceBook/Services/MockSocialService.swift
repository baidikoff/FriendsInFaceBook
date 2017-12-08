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
    
    open static let users = [User(name: "Ivan Ivanov", image: UserImageData(urlData: UserImage(url: "https://cdn.pixabay.com/photo/2016/12/09/12/24/giraffe-1894778_960_720.jpg"))), User(name: "Vasiliy Vasichkin", image: UserImageData(urlData: UserImage(url: "https://cdn.pixabay.com/photo/2016/12/09/12/24/giraffe-1894778_960_720.jpg")))]
    
    open func requestUsers() -> Promise<[User]> {
        return Promise<[User]>{ fulfill,_ in 
            fulfill(MockSocialService.users)
        }
    }
    open func loginUser() {
        
    }
    
    open func logoutUser() {
        
    }
    
}
