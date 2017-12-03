//
//  ListOfFriendsTableViewController.swift
//  FriendsInFaceBook
//
//  Created by Viktoria on 11/28/17.
//  Copyright © 2017 Victoria Kravets. All rights reserved.
//

import UIKit
import RealmSwift
import FBSDKLoginKit
import FBSDKCoreKit
import PromiseKit

class ListOfFriendsTableViewController: UITableViewController {

    @IBOutlet weak var logoutButton: FBSDKLoginButton!
    let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
    var friends: Results<User>!
    fileprivate var notificationToken: NotificationToken? = nil
    let api = ApiLayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getFriendsFromStorage()
        self.requestFriends()
        self.configurePullToRefresh()
        
    }
    
    @IBAction func logoutButtonPressed(_ sender: FBSDKLoginButton) {
        let logout = UIAlertController(title: "Log Out", message: "Are you sure you want to log out?", preferredStyle: UIAlertControllerStyle.alert)
        logout.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (action: UIAlertAction!) in
            let loginManager = FBSDKLoginManager()
            loginManager.logOut()
            let loginViewController = self.storyBoard.instantiateViewController(withIdentifier: "LoginVC") as! LoginViewController
            self.present(loginViewController, animated:true, completion:nil)
        }))
        logout.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
            print("Cancel")
        }))
        present(logout, animated: true, completion: nil)
    }
    func configurePullToRefresh() {
        refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: #selector(requestFriends), for: UIControlEvents.valueChanged)
        self.tableView?.insertSubview(refreshControl!, at: 0)
    }
    func getFriendsFromStorage(){
        do {
            let realm = try Realm()
            self.friends = realm.objects(User.self)
            tableView.reloadData()
            self.refreshControl?.endRefreshing()
        } catch let error {
            fatalError("\(error)")
        }
    }
    func configureRealmNotification() {
        self.notificationToken = self.friends.observe { [weak self] (changes: RealmCollectionChange) in
            switch changes {
            case .initial,.update:
                self?.tableView.reloadData()
                break
            case .error(let error):
                fatalError("\(error)")
                break
            }
        }
    }
    @objc func requestFriends(){
        firstly{
            ApiLayer.shared.requestUsersPromise()
            }.then{  [weak self] users -> Void in
                self?.reloadStorage(user: users)
        }
    }
  
    func reloadStorage(user: Array<User>){
        do {
            let realm = try Realm()
            try realm.write {
                realm.deleteAll()
            }
            self.configureRealmNotification()
            try realm.write {
                realm.add(user)
            }
        } catch let error {
            fatalError("\(error)")
        }
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.friends.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "FriendCell",
                                                    for: indexPath) as? FriendTableViewCell {
            let friend = self.friends[indexPath.row]
            cell.configureCell(user: friend)
            return cell
        }
        return UITableViewCell()
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let friendsVC = self.storyBoard.instantiateViewController(withIdentifier: "TableView") as! ListOfFriendsTableViewController
        self.navigationController?.pushViewController(friendsVC, animated: true)
    }
    
}
