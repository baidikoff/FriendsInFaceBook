//
//  UserView.swift
//  FriendsInFaceBook
//
//  Created by Oleksa 'trimm' Korin on 3/30/18.
//  Copyright © 2018 Victoria Kravets. All rights reserved.
//

import UIKit

public class UserView: UIView {
    
    // MARK: -
    // MARK: Properties
    
    @IBOutlet private var nameLabel: UILabel?
    @IBOutlet private var ageLabel: UILabel?
    
    public var user: User? {
        didSet { self.fill(with: user) }
    }
    
    // MARK: -
    // MARK: Private
    
    private func fill(with user: User?) {
        let update = { [weak self, weak user] in
            self?.nameLabel?.text = user?.name.map { "Name: \($0)" }
            self?.ageLabel?.text = user?.age.map { "Age: \($0)" }
        }

        user?.didChange = update
        update()
    }
}
