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
    var image: UserWithData?
    
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
class UserWithData: Mappable{

    var urlData: Image?
    required init?(map: Map) {
      //  self.init()
    }
    
    func mapping(map: Map) {
       // super.mapping(map: map)
        urlData       <- map["data"]
    }
}
class Image: Mappable{
    @objc dynamic var url: String?

    required  init?(map: Map) {
       // self.init(map: map)
    }

    func mapping(map: Map) {
       // super.mapping(map: map)
        url       <- map["url"]
    }
}

