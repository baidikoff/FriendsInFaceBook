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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func configureCell(user: User) {
        userName.text = user.name
        fetchImage(imageUrl: user.imageUrl)
    }
    func fetchImage(imageUrl: String){
        let url = URL(string: imageUrl)
            DispatchQueue.global(qos: .userInitiated).async{
                let data = NSData(contentsOf: url!)
                DispatchQueue.main.async{
                    if let imageData = data {
                        self.userPhoto.image = UIImage(data: data! as Data)
                    }
                }
            }
        }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
