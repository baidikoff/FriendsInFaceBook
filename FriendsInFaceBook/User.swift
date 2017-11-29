//
//  User.swift
//  FriendsInFaceBook
//
//  Created by Viktoria on 11/28/17.
//  Copyright © 2017 Victoria Kravets. All rights reserved.
//

import Foundation
import RealmSwift

class User: Object {
    @objc dynamic var name: String!
    @objc dynamic var imageUrl: String!
    @objc dynamic var id: String!
    convenience init(name: String, imageUrl: String, id: String) {
        self.init()
        self.name = name
        self.imageUrl = imageUrl
        self.id = id
    }
}
