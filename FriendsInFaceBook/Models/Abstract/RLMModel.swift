//
//  RLMModel.swift
//  FriendsInFaceBook
//
//  Created by Oleksa 'trimm' Korin on 2/13/18.
//  Copyright © 2018 Victoria Kravets. All rights reserved.
//

import Foundation

import RealmSwift

public class RLMModel: Object {
    
    // MARK: -
    // MARK: Class
    
    @objc open override class func primaryKey() -> String? {
        return "id"
    }
    
    // MARK: -
    // MARK: Properties
    
    @objc dynamic var id = ""
}
