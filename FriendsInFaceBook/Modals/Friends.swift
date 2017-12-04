//
//  Friends.swift
//  FriendsInFaceBook
//
//  Created by Viktoria on 12/3/17.
//  Copyright © 2017 Victoria Kravets. All rights reserved.
//


import Foundation
import RealmSwift
import ObjectMapper

class Friends: Mappable {
    
    var friends: [User]?

    required init?(map: Map) {

    }
    
    func mapping(map: Map) {
        friends   <- map["data"]
    }
}
