//
//  RLMModel.swift
//  FriendsInFaceBook
//
//  Created by Admin on 20.02.2018.
//  Copyright © 2018 Victoria Kravets. All rights reserved.
//

import Foundation
import RealmSwift

public class RLMModel: Object {
    
    // MARK: -
    // MARK: Properties
    
    @objc open override class func primaryKey() -> String? {
        return "id"
    }
    
    @objc dynamic var id = ""
}
