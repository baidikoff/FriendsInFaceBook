//
//  ListOfFriendsTableViewController.swift
//  FriendsInFaceBook
//
//  Created by Viktoria on 11/28/17.
//  Copyright © 2017 Victoria Kravets. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import FBSDKCoreKit

class ListOfFriendsTableViewController: UITableViewController {

    @IBOutlet weak var logOut: UIBarButtonItem!
    var friends1 = [1, 1, 3, 1, 1, 3, 1, 1, 3, 1]
    var friends = [User]()
    override func viewDidLoad() {
        super.viewDidLoad()

        self.fetchProfile()
    }

    func fetchProfile(){
        let parameters = ["fields": "name, picture.type(normal), gendar"]
        FBSDKGraphRequest(graphPath: "me/taggable_friends", parameters: parameters).start{ connection, users, error -> Void in
            
            if error != nil {
                print(error)
                return
            }
            guard let dict: Dictionary = users! as? Dictionary<String, Any> else {return print("Users is nil")}
            if let friends = dict["data"] as? Array<Dictionary<String, Any>>{
                for friend in friends{
                    print(friend)
                    if let userName = friend["name"] as? String{
                        if let id = friend["id"] as? String{
                            if let picture = friend["picture"] as? Dictionary<String, Any>{
                                if let data = picture["data"] as? Dictionary<String, Any>{
                                    if let imageUrl = data["url"] as? String{
                                        print(imageUrl)
                                        let user = User(name: userName, imageUrl: imageUrl, id: id)
                                        self.friends.append(user)
                                    }
                                }
                            }
                        }
                    }
                }
                self.tableView.reloadData()
            }
            
        }
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return friends.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "FriendCell",
                                                    for: indexPath) as? FriendTableViewCell {
            let friend = friends[indexPath.row]
            cell.configureCell(user: friend)
            return cell
        }
        return UITableViewCell()
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    

}
