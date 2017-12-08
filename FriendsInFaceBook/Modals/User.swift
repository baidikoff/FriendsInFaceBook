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

public class User: Object, Mappable {
    
    // MARK: -
    // MARK: Properties
    
    @objc dynamic var name: String?
    @objc dynamic var id: String?
    @objc dynamic var image: UserImageData?
    
    convenience init(name: String, image: UserImageData) {
        self.init()
        self.name = name
        self.image = image
    }
    required convenience public init?(map: Map) {
        self.init()
    }

    public func mapping(map: Map) {
            name       <- map["name"]
            id     <- map["id"]
            image    <- map["picture"]
    }
}
class UserImageData: Object, Mappable {

    @objc dynamic var urlData: UserImage?
    required convenience init?(map: Map) {
        self.init()
    }
    convenience init(urlData: UserImage) {
        self.init()
        self.urlData = urlData
    }
    func mapping(map: Map) {
        urlData       <- map["data"]
    }
}
class UserImage: Object, Mappable{
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

