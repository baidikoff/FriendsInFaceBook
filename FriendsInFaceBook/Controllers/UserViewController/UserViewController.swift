//
//  UserViewController.swift
//  FriendsInFaceBook
//
//  Created by Oleksa 'trimm' Korin on 3/30/18.
//  Copyright © 2018 Victoria Kravets. All rights reserved.
//

import UIKit

public class UserViewController: UIViewController {
    
    // MARK: -
    // MARK: Properties
    
    public var userView: UserView? {
        return cast(self.viewIfLoaded)
    }
    
    public var user: User? {
        didSet { self.userView?.user = user }
    }
    
    // MARK: -
    // MARK: View Lifecycle
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        self.userView?.user = self.user
    }
}
