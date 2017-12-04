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
    
    convenience init(name: String, imageUrl: String) {
        self.init()
        self.name = name
        self.imageUrl = imageUrl
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
//class UserWithData: UserWithoutImage{
//
//    var urlData: User?
//    required convenience override init?(map: Map) {
//        self.init(map: map)
//    }
//
//    override func mapping(map: Map) {
//       // super.mapping(map: map)
//        urlData       <- map["data"]
//    }
//}
//class User: UserWithData{
//    @objc dynamic var url: String?
//
//    required convenience init?(map: Map) {
//        self.init(map: map)
//    }
//
//    override func mapping(map: Map) {
//        super.mapping(map: map)
//        url       <- map["url"]
//    }
//}
