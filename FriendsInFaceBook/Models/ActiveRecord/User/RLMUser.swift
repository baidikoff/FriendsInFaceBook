//
//  RLMUser.swift
//  FriendsInFaceBook
//
//  Created by Oleksa 'trimm' Korin on 2/13/18.
//  Copyright © 2018 Victoria Kravets. All rights reserved.
//

import Foundation

import RealmSwift

public class RLMUser: RLMModel {
    
    // MARK: -
    // MARK: Properties
    
    @objc dynamic var name: String?
    let age = RealmOptional<Int>()
}
