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
    
    @IBOutlet weak var loginView: LoginView?
    var hasToken = false
    let facebookApi = FacebookApi()
    var socialService: SocialServiceImpl?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.socialService = SocialServiceImpl(facebookApi)
        self.loginView?.loginButton?.addTarget(self, action: #selector(loginButtonPressed), for: .touchUpInside)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        socialService.do { self.hasToken = $0.isAlreadyLoggedIn }
        self.goToNextViewController()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        self.goToNextViewController()
    }
    
    // MARK: -
    // MARK: Private
    
    private func goToNextViewController(){
        if hasToken {
            let storyBoard : UIStoryboard = UIStoryboard(name: Constants.Main, bundle:nil)
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: Constants.storyBoardIdentifier) as? UINavigationController
            nextViewController.do({self.present($0, animated:true, completion:nil)})
        }
    }
    @objc func loginButtonPressed(){
        self.socialService?.loginUser()
    }
}

