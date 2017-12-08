//
//  ViewController.swift
//  FriendsInFaceBook
//
//  Created by Viktoria on 11/27/17.
//  Copyright © 2017 Victoria Kravets. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    // MARK: -
    // MARK: Properties
    
    let loginView = LoginView()
    var hasToken = false
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(loginView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.hasToken = FacebookSocialService.shared.alreadyLoggedIn()
        if hasToken {
            self.loginView.loginButton?.isHidden = true
            self.loginView.welcomeLabel?.isHidden = true
            self.goToNextViewController()
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        if hasToken {
           self.goToNextViewController()
        }
    }
    
    // MARK: -
    // MARK: Private
    
    private func goToNextViewController(){
        let storyBoard : UIStoryboard = UIStoryboard(name: Constants.Main, bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: Constants.storyBoardIdentifier) as? UINavigationController
        nextViewController.do({ nextVC in
             self.present(nextVC, animated:true, completion:nil)
        })
    }
}

