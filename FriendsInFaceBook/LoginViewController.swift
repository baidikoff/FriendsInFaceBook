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

class LoginViewController: UIViewController {

    @IBOutlet weak var loginButton: FBSDKLoginButton!
    @IBOutlet weak var welcomeLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loginButton.readPermissions = ["public_profile", "email", "user_friends"]
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        if let accessToken = FBSDKAccessToken.current() {
            self.loginButton.isHidden = true
            self.welcomeLabel.isHidden = true
            self.goToNextViewController()
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        if let accessToken = FBSDKAccessToken.current() {
           self.goToNextViewController()
        }
    }
    func goToNextViewController(){
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "GoToSeeFriends") as! UINavigationController
        self.present(nextViewController, animated:true, completion:nil)
    }

    

}

