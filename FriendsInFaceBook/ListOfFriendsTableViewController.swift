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

class ListOfFriendsTableViewController: UITableViewController {

    @IBOutlet weak var logoutButton: FBSDKLoginButton!
    let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
    var friends: Results<User>!
    fileprivate var notificationToken: NotificationToken? = nil
    
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
        let parameters = ["fields": "name, picture.type(normal), gendar"]
        FBSDKGraphRequest(graphPath: "me/taggable_friends", parameters: parameters).start{ connection, users, error -> Void in
            if error != nil {
                let errorRefreshAlert = UIAlertController(title: "There is no Internet connection", message: "Please check the network cables, modem, router and connection to Wi-Fi", preferredStyle: UIAlertControllerStyle.alert)
                errorRefreshAlert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default,handler: { (action: UIAlertAction!) in
                        self.refreshControl?.endRefreshing()
                    }))
                self.present(errorRefreshAlert, animated: true, completion: nil)
                return
            }
            do {
                let realm = try Realm()
                try realm.write {
                    realm.deleteAll()
                }
                self.configureRealmNotification()
            } catch let error {
                fatalError("\(error)")
            }
            guard let dict: Dictionary = users! as? Dictionary<String, Any> else {return print("Users is nil")}
            if let friends = dict["data"] as? Array<Dictionary<String, Any>>{
                for friend in friends{
                    if let userName = friend["name"] as? String{
                        if let id = friend["id"] as? String{
                            if let picture = friend["picture"] as? Dictionary<String, Any>{
                                if let data = picture["data"] as? Dictionary<String, Any>{
                                    if let imageUrl = data["url"] as? String{
                                        let user = User(name: userName, imageUrl: imageUrl, id: id)
                                        self.writeUserInRealm(user: user)
                                    }
                                }
                            }
                        }
                    }
                }
                self.getFriendsFromStorage()
            }
        }
    }
    func writeUserInRealm(user: User){
        do {
            let realm = try Realm()
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
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    
    
    
}
