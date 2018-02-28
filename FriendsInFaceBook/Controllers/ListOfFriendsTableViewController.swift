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
    var friends: Results<RealmUser>?
    fileprivate var notificationToken: NotificationToken? = nil
    let facebookApi = FacebookApi()
    var socialService: SocialServiceImpl?
    private var cancellable: Cancellable?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.socialService = SocialServiceImpl(self.facebookApi)
        self.cancellable = ServiceTask(self.facebookApi)
        self.refreshControl = UIRefreshControl()
        self.requestObjects()
        self.configurePullToRefresh()
        self.configureNavigationItems()
    }
    
    // MARK: -
    // MARK: Private
    
    private func configureNavigationItems() {
        self.logoutButton = UIBarButtonItem(title: Constants.LogOut, style: .plain, target: self, action: #selector(logoutButtonPressed))
        navigationItem.rightBarButtonItem = self.logoutButton
    }
    
    @objc private func logoutButtonPressed(_ sender: UIButton) {
        let logout = UIAlertController(title: Constants.LogOut, message: Constants.LogOutMessage, preferredStyle: UIAlertControllerStyle.alert)
        logout.addAction(UIAlertAction(title: Constants.Yes, style: .default, handler: { (action: UIAlertAction?) in
            self.socialService?.logoutRealmUser()
            self.presentingViewController?.dismiss(animated: true, completion: nil)
        }))
        logout.addAction(UIAlertAction(title: Constants.cancel, style: .cancel, handler: { (action: UIAlertAction?) in
            print(Constants.cancel)
        }))
        present(logout, animated: true, completion: nil)
    }
    
    private func configurePullToRefresh() {
        self.refreshControl?.addTarget(self, action: #selector(requestObjects), for: UIControlEvents.valueChanged)
        self.refreshControl.do( { self.tableView?.insertSubview($0, at: 0) })
        self.tableView.reloadData()
    }
    
    private func getFriendsFromStorage() {
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
    
    @objc private func requestObjects() {
        self.requestFriends {
            self.getFriendsFromStorage()
            self.refreshControl?.endRefreshing()
        }
    }
    
    // MARK: -
    // MARK: Open
    
    open func requestFriends(completion: @escaping () -> ()) {
        self.cancellable = self.socialService?.requestRealmUsers { [weak self] users in
            ServiceForData.shared.deleteAllDataInStorage()
            self?.configureRealmNotification()
            print(users)
            ServiceForData.shared.writeDataInStorage(users: users)
            completion()
        }
    }
    
    // MARK: -
    // MARK: TableView
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.friends?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.RealmUserCellIdentifier, for: indexPath) as? RealmUserCell
        self.friends.do({ friends in
            let friend = friends[indexPath.row]
            cell?.user = friend
        })
        return cell ?? UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let friendsVC = self.storyBoard.instantiateViewController(withIdentifier: Constants.ListOfFriendsTVCIdentifier) as? ListOfFriendsTableViewController
        friendsVC.do({ self.navigationController?.pushViewController($0, animated: true)})
    }
}
