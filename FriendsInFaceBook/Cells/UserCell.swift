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
    @IBOutlet private(set) var photoImageView: ImageView?
    
    var user: RealmUser? {
        didSet { self.fill(with: user) }
    }
    
    // MARK: -
    // MARK: Open
    
    open func fill(with model: RealmUser?) {
        self.nameLabel?.text = self.user?.name
        self.user.do(self.fillPhoto)
    }
    
    open override func prepareForReuse() {
        super.prepareForReuse()
        
        self.nameLabel?.text = nil
        self.photoImageView?.prepareForReuse()
    }
    
    // MARK: -
    // MARK: Private
    
    private func fillPhoto(with user: RealmUser) {
        let imageDownloadService = ImageDownloadServiceImpl(
            networkService: NetworkServiceImpl(session: URLSession(configuration: .default))
        )
        
        self.photoImageView?.model = (user.image?.urlData?.url)
            .flatMap(URL.init(string:))
            .map { ImageModelImpl.init(url: $0, imageLoadService: imageDownloadService) }
    }
}
