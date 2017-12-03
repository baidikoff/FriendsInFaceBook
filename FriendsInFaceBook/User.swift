//
//  User.swift
//  FriendsInFaceBook
//
//  Created by Viktoria on 11/28/17.
//  Copyright © 2017 Victoria Kravets. All rights reserved.
//

import Foundation
import RealmSwift
import ObjectMapper

class User: Object, Mappable {
    
    @objc dynamic var name: String?
    @objc dynamic var imageUrl: String?
    @objc dynamic var id: String?
    
    convenience init(name: String, imageUrl: String, id: String) {
        self.init()
        self.name = name
        self.imageUrl = imageUrl
        self.id = id
    }
    required convenience init?(map: Map) {
        self.init()
    }

    func mapping(map: Map) {
            name       <- map["name"]
            id     <- map["id"]
            imageUrl    <- map["data"]
    }
}
class UserImage{
    @objc dynamic var url: String?
    
    convenience init(url: String) {
        self.init()
        self.url = url
    }
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        url       <- map["url"]
    }
}
