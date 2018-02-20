//
//  RLMUser.swift
//  FriendsInFaceBook
//
//  Created by Admin on 20.02.2018.
//  Copyright © 2018 Victoria Kravets. All rights reserved.
//

import Foundation
import RealmSwift

class RLMUser: RLMModel {
    
    @objc dynamic var name: String?
    var age: Int?
    
}
