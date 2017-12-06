//
//  ServiceForData.swift
//  FriendsInFaceBook
//
//  Created by Viktoria on 12/3/17.
//  Copyright © 2017 Victoria Kravets. All rights reserved.
//

import Foundation
import RealmSwift
import PromiseKit

class ServiceForData{
    
    static let shared = ServiceForData()
    fileprivate var notificationToken: NotificationToken? = nil
    
    func deleteAllDataInStorage() {
        do {
            let realm = try Realm()
            try realm.write {
                realm.deleteAll()
            }
        } catch let error {
            fatalError("\(error)")
        }
    }
    func writeDataInStorage(users: [User]) {
        do {
            let realm = try Realm()
            try realm.write {
                realm.add(users)
            }
        } catch let error {
            fatalError("\(error)")
        }
    }
    func getDataFromStorage() -> Results<User>{
        var users: Results<User>?
        do {
            let realm = try Realm()
            users = realm.objects(User.self)
        } catch let error {
            fatalError("\(error)")
        }
        return users!
    }
    
    
}
