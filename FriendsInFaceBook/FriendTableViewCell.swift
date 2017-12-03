//
//  FriendTableViewCell.swift
//  FriendsInFaceBook
//
//  Created by Viktoria on 11/28/17.
//  Copyright © 2017 Victoria Kravets. All rights reserved.
//

import UIKit

class FriendTableViewCell: UITableViewCell {

    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userPhoto: UIImageView!
    
    func configureCell(user: User) {
        userName.text = user.name
        //fetchImage(imageUrl: user.imageUrl!)
    }
    func fetchImage(imageUrl: String){
        let url = URL(string: imageUrl)
            DispatchQueue.global(qos: .userInitiated).async{
                let data = NSData(contentsOf: url!)
                DispatchQueue.main.async{
                    if data != nil {
                        self.userPhoto.image = UIImage(data: data! as Data)
                    }
                }
            }
        }

}
