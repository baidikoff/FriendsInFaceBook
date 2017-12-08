//
//  loginView.swift
//  FriendsInFaceBook
//
//  Created by Viktoria on 12/5/17.
//  Copyright © 2017 Victoria Kravets. All rights reserved.
//

import UIKit

class LoginView: UIView {
    
    // MARK: -
    // MARK: Properties
    
    @IBOutlet weak var loginButton: UIButton?
    @IBOutlet weak var welcomeLabel: UILabel?
   
    // MARK: -
    // MARK: Private
    
    @IBAction private func loginButtonPressed(_ sender: Any) {
        FacebookSocialService.shared.loginUser()
        
    }
}
