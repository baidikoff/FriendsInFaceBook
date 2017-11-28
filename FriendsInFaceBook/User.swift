//
//  User.swift
//  FriendsInFaceBook
//
//  Created by Viktoria on 11/28/17.
//  Copyright © 2017 Victoria Kravets. All rights reserved.
//

import Foundation
class User {
    var name: String!
    var imageUrl: String!
    var id: String!
    init(name: String, imageUrl: String, id: String) {
        self.name = name
        self.imageUrl = imageUrl
        self.id = id
    }
}
