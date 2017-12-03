//
//  ViewController.swift
//  FriendsInFaceBook
//
//  Created by Viktoria on 11/27/17.
//  Copyright © 2017 Victoria Kravets. All rights reserved.
//

import UIKit

public class LoginViewController: UIViewController {

    @IBOutlet weak var loginButton: UIButton?
    @IBOutlet weak var welcomeLabel: UILabel?
    
    
    override public func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override public func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        if ApiLayer.shared.alreadyLoggedIn() == true {
            self.loginButton?.isHidden = true
            self.welcomeLabel?.isHidden = true
            self.goToNextViewController()
        }
    }
    override public func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        if ApiLayer.shared.alreadyLoggedIn() == true {
           self.goToNextViewController()
        }
    }
    @IBAction func loginButtonPressed(_ sender: Any) {
        ApiLayer.shared.loginUser()
    }
    func goToNextViewController(){
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "GoToSeeFriends") as! UINavigationController
        self.present(nextViewController, animated:true, completion:nil)
    }

    

}

