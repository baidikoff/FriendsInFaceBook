//
//  RLMUser.swift
//  FriendsInFaceBook
//
//  Created by Admin on 20.02.2018.
//  Copyright © 2018 Victoria Kravets. All rights reserved.
//

import Foundation
import RealmSwift

public class RLMUser: RLMModel, UserStorage {
    
    // MARK: -
    // MARK: Properties
    
    @objc dynamic public var name: String?
    public var age: Int?
}
