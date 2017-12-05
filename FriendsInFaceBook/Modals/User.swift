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
    @objc dynamic var id: String?
    @objc dynamic var image: UserWithData?
    
    convenience init(name: String) {
        self.init()
        self.name = name
    }
    required convenience init?(map: Map) {
        self.init()
    }

    func mapping(map: Map) {
            name       <- map["name"]
            id     <- map["id"]
            image    <- map["picture"]
    }
}
class UserWithData: Object, Mappable {

    @objc dynamic var urlData: Image?
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
       // super.mapping(map: map)
        urlData       <- map["data"]
    }
}
class Image: Object, Mappable{
    @objc dynamic var url: String?

    required convenience init?(map: Map) {
        self.init()
    }

    func mapping(map: Map) {
       // super.mapping(map: map)
        url       <- map["url"]
    }
}

