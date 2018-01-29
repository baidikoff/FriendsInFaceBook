//
//  SocialService.swift
//  FriendsInFaceBook
//
//  Created by Viktoria on 1/28/18.
//  Copyright © 2018 Victoria Kravets. All rights reserved.
//

import Foundation

public protocol SocialService{
    
    // MARK: -
    // MARK: Properties
    
    var isAlreadyLoggedIn: Bool { get }
    
    // MARK: -
    // MARK: Public
    
    func requestUsers() -> Cancellable
    func logoutUser()
    func loginUser()
}

