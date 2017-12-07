//
//  ListOfFriendsTableViewController.swift
//  FriendsInFaceBook
//
//  Created by Viktoria on 11/28/17.
//  Copyright © 2017 Victoria Kravets. All rights reserved.
//

import UIKit
import RealmSwift
import PromiseKit

class ListOfFriendsTableViewController: UITableViewController {
    
    var logoutButton: UIBarButtonItem?
    let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
    var friends: Results<User>?
    fileprivate var notificationToken: NotificationToken? = nil
    var facebookSocialService: SocialService = FacebookSocialService()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.getFriendsFromStorage()
        self.configurePullToRefresh()
        self.configureNavigationItems()
    }
    
    func configureNavigationItems()  {
        self.logoutButton = UIBarButtonItem(title: "Log Out", style: .plain, target: self, action: #selector(logoutButtonPressed))
        navigationItem.rightBarButtonItem = self.logoutButton
    }
    @objc func logoutButtonPressed(_ sender: UIButton) {
        let logout = UIAlertController(title: "Log Out", message: "Are you sure you want to log out?", preferredStyle: UIAlertControllerStyle.alert)
        logout.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (action: UIAlertAction?) in
            FacebookSocialService.shared.logoutUser()
            let loginViewController = self.storyBoard.instantiateViewController(withIdentifier: "LoginVC") as? LoginViewController
            loginViewController.do{ loginVC in
                self.present(loginVC, animated:true, completion:nil)
            }
        }))
        logout.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction?) in
            print("Cancel")
        }))
        present(logout, animated: true, completion: nil)
    }
    func configurePullToRefresh(){
        self.refreshControl = UIRefreshControl()
        self.refreshControl?.addTarget(self, action: #selector(requestObjects), for: UIControlEvents.valueChanged)
        self.refreshControl.do({ refresh in
             self.tableView?.insertSubview(refresh, at: 0) //how I avoided "!"
        })
    }
    func getFriendsFromStorage(){
        self.friends = ServiceForData.shared.getDataFromStorage()
        self.tableView.reloadData()
        self.refreshControl?.endRefreshing()
        
    }
    func configureRealmNotification() {
        self.notificationToken = self.friends?.observe { [weak self] (changes: RealmCollectionChange) in
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
    @objc func requestObjects(){
        self.requestFriends().then{ _ -> Void in
            self.getFriendsFromStorage()
            self.refreshControl?.endRefreshing()
        }
    }
    func requestFriends() -> Promise<String>{
        return Promise<String>{ fulfill,_ in
            firstly{
                self.facebookSocialService.requestUsers()
                }.then{  [weak self] users -> Void in
                    ServiceForData.shared.deleteAllDataInStorage()
                    self?.configureRealmNotification()
                    ServiceForData.shared.writeDataInStorage(users: users)
                    fulfill("Success")
            }
        }

    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.friends?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "FriendCell",
                                                    for: indexPath) as? UserCell {
            self.friends.do({ friends in
                let friend = friends[indexPath.row]
                cell.user = friend
            })
            return cell
        }
        
       return UITableViewCell()
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let friendsVC = self.storyBoard.instantiateViewController(withIdentifier: "TableView") as? ListOfFriendsTableViewController
        friendsVC.do({ friendsVC in
            self.navigationController?.pushViewController(friendsVC, animated: true)
        })
        
    }
    
}
