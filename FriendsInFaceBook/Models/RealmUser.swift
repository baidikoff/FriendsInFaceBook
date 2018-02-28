//
//  RealmUser.swift
//  FriendsInFaceBook
//
//  Created by Viktoria on 11/28/17.
//  Copyright © 2017 Victoria Kravets. All rights reserved.
//

import Foundation
import RealmSwift
import ObjectMapper

public class RealmUser: Object, Mappable {
    
    // MARK: -
    // MARK: Properties
    
    @objc dynamic var name: String?
    @objc dynamic var id: String?
    @objc dynamic var image: RealmUserImageData?
    
    convenience init(name: String, image: RealmUserImageData) {
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
class RealmUserImageData: Object, Mappable {

    @objc dynamic var urlData: RealmUserImage?
    required convenience init?(map: Map) {
        self.init()
    }
    convenience init(urlData: RealmUserImage) {
        self.init()
        self.urlData = urlData
    }
    func mapping(map: Map) {
        urlData       <- map["data"]
    }
}
class RealmUserImage: Object, Mappable{
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

