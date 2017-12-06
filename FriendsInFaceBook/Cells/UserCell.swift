//
//  FriendTableViewCell.swift
//  FriendsInFaceBook
//
//  Created by Viktoria on 11/28/17.
//  Copyright © 2017 Victoria Kravets. All rights reserved.
//

import UIKit

class UserCell: UITableViewCell {

    // MARK: -
    // MARK: Properties
    
    @IBOutlet private(set) var nameLabel: UILabel?
    @IBOutlet private(set) var photoImageView: UIImageView?
    
    var user: User? {
        didSet { self.fill(with: user) }
    }
    
    // MARK: -
    // MARK: Open
    
    open func fill(with model: User?) {
        self.nameLabel?.text = self.user?.name
        self.user.do(self.fillPhoto)
    }
    
    open override func prepareForReuse() {
        super.prepareForReuse()
        
        self.nameLabel?.text = nil
        self.photoImageView?.image = nil
    }
    
    // MARK: -
    // MARK: Private
    
    private func fillPhoto(with user: User) {
        let urlString = user.image?.urlData?.url
        urlString
            .flatMap(URL.init(string:))
            .do(self.fetchImageAndFillPhoto)
    }
    
    private func fetchImageAndFillPhoto(at url: URL) {
        let user = self.user

        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            let image = NSData(contentsOf: url)
                .flatMap(cast)
                .flatMap(UIImage.init(data:))
            
            DispatchQueue.main.async {
                if user?.id == self?.user?.id {
                    self?.photoImageView?.image = image
                }
            }
        }
    }
}
