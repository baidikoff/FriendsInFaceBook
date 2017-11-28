//
//  ViewController.swift
//  FriendsInFaceBook
//
//  Created by Viktoria on 11/27/17.
//  Copyright © 2017 Victoria Kravets. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit

class LoginViewController: UIViewController, FBSDKLoginButtonDelegate {
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        print("LogOut")
    }
    
   
    @IBOutlet weak var loginButton: FBSDKLoginButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loginButton.readPermissions = ["public_profile", "email", "user_friends"]
        
        
    }
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {

        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        if let accessToken = FBSDKAccessToken.current() {
            print("Token: ", accessToken.tokenString)
            print(accessToken.userID)
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "GoToSeeFriends") as! ListOfFriendsTableViewController
            self.present(nextViewController, animated:true, completion:nil)
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}

