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
    
    // MARK: -
    // MARK: Properties
    
    var logoutButton: UIBarButtonItem?
    let storyBoard : UIStoryboard = UIStoryboard(name: Constants.Main, bundle:nil)
    var friends: Results<User>?
    fileprivate var notificationToken: NotificationToken? = nil
    var facebookSocialService: SocialService = FacebookSocialService()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.refreshControl = UIRefreshControl()
        self.getFriendsFromStorage()
        self.configurePullToRefresh()
        self.configureNavigationItems()
    }
    
    // MARK: -
    // MARK: Private
    
    private func configureNavigationItems()  {
        self.logoutButton = UIBarButtonItem(title: Constants.LogOut, style: .plain, target: self, action: #selector(logoutButtonPressed))
        navigationItem.rightBarButtonItem = self.logoutButton
    }
    
    @objc private func logoutButtonPressed(_ sender: UIButton) {
        let logout = UIAlertController(title: Constants.LogOut, message: Constants.LogOutMessage, preferredStyle: UIAlertControllerStyle.alert)
        logout.addAction(UIAlertAction(title: Constants.Yes, style: .default, handler: { (action: UIAlertAction?) in
            FacebookSocialService.shared.logoutUser()
            let loginViewController = self.storyBoard.instantiateViewController(withIdentifier: Constants.LoginVCIdentifier) as? LoginViewController
            loginViewController.do{ loginVC in
                self.present(loginVC, animated:true, completion:nil)
            }
        }))
        logout.addAction(UIAlertAction(title: Constants.cancel, style: .cancel, handler: { (action: UIAlertAction?) in
            print(Constants.cancel)
        }))
        present(logout, animated: true, completion: nil)
    }
    
    private func configurePullToRefresh(){
        self.refreshControl?.addTarget(self, action: #selector(requestObjects), for: UIControlEvents.valueChanged)
        self.refreshControl.do({ refresh in
             self.tableView?.insertSubview(refresh, at: 0)
        })
    }
    
    private func getFriendsFromStorage(){
        self.friends = ServiceForData.shared.getDataFromStorage()
        self.tableView.reloadData()
        self.refreshControl?.endRefreshing()     
    }
    
    private func configureRealmNotification() {
        self.notificationToken = self.friends?.observe { [weak self] (changes: RealmCollectionChange) in
            switch changes {
            case .initial,.update:
                self?.tableView.reloadData()
                break
            case .error(let error):
                print("Error: \(error)")
                break
            }
        }
    }
    
    @objc private func requestObjects(){
        self.requestFriends().then{ _ -> Void in
            self.getFriendsFromStorage()
            self.refreshControl?.endRefreshing()
        }
    }
    
    // MARK: -
    // MARK: Open
    
    open func requestFriends() -> Promise<String>{
        return Promise<String>{ fulfill,_ in
            firstly{
                self.facebookSocialService.requestUsers()
                }.then{  [weak self] users -> Void in
                    ServiceForData.shared.deleteAllDataInStorage()
                    self?.configureRealmNotification()
                    ServiceForData.shared.writeDataInStorage(users: users)
                    fulfill(Constants.success)
            }
        }
    }
    
    // MARK: -
    // MARK: TableView
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.friends?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.UserCellIdentifier, for: indexPath) as? UserCell
        self.friends.do({ friends in
            let friend = friends[indexPath.row]
            cell?.user = friend
        })
        return cell ?? UITableViewCell()
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let friendsVC = self.storyBoard.instantiateViewController(withIdentifier: Constants.ListOfFriendsTVCIdentifier) as? ListOfFriendsTableViewController
        friendsVC.do({ friendsVC in
            self.navigationController?.pushViewController(friendsVC, animated: true)
        })
    }
    
}
