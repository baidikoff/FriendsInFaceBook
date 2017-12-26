//
//  Reusable.swift
//  FriendsInFaceBook
//
//  Created by Oleksa 'trimm' Korin on 12/20/17.
//  Copyright © 2017 Victoria Kravets. All rights reserved.
//

import UIKit

public protocol Reusable {
    func prepareForReuse()
}

extension UITableViewCell: Reusable { }
extension UICollectionViewCell: Reusable { }
