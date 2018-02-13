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
    
    // MARK: -
    // MARK: Open
    
    open func deleteAllDataInStorage() {
        let realm = try? Realm()
        realm.do({ realm in
            try? realm.write {
            realm.deleteAll()
            }
        })
    }
    open func writeDataInStorage(users: [RealmUser]) {
        let realm = try? Realm()
        realm.do({ realm in
            try? realm.write {
                realm.add(users)
            }
        })
    }
    open func getDataFromStorage() -> Results<RealmUser>?{
        var users: Results<RealmUser>? = nil
        let realm = try? Realm()
        realm.do({ users = $0.objects(RealmUser.self)})
        return users
    }
}
