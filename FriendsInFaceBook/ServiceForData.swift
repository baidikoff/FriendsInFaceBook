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
    func writeDataInStorage(users: Array<User>) {
        do {
            let realm = try Realm()
            try realm.write {
                realm.add(users)
            }
        } catch let error {
            fatalError("\(error)")
        }
    }
    func getDataFromStorage() -> Promise<Results<User>>{
        return Promise<Results<User>>{ fulfill, reject in
            do {
                let realm = try Realm()
                let dataFromStorame = realm.objects(User.self)
                fulfill(dataFromStorame)
            } catch let error {
                fatalError("\(error)")
                reject(error)
            }
        }
    }
   
    
}
