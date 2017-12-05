//
//  ViewController.swift
//  FriendsInFaceBook
//
//  Created by Viktoria on 11/27/17.
//  Copyright © 2017 Victoria Kravets. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    let loginView = LoginView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(loginView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        if FacebookSocialService.shared.alreadyLoggedIn() == true {
           self.loginView.loginButton?.isHidden = true
            self.loginView.welcomeLabel?.isHidden = true
            self.goToNextViewController()
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        if FacebookSocialService.shared.alreadyLoggedIn() == true {
           self.goToNextViewController()
        }
    }

    func goToNextViewController(){
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "GoToSeeFriends") as! UINavigationController
        self.present(nextViewController, animated:true, completion:nil)
    }

    

}

