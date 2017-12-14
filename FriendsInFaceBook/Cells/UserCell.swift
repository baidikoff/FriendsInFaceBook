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
    
    private var task = CancellableProperty()
    
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
        let imageDownloadService = ImageDownloadServiceImpl(
            networkService: NetworkServiceImpl(session: URLSession(configuration: .default))
        )
        
        let urlString = user.image?.urlData?.url
        urlString
            .flatMap(URL.init(string:))
            .do { url in
                self.task.value = imageDownloadService.fetchImage(url: url) { [weak self, user = self.user] image in
                    let isSameUser = { user?.id == self?.user?.id }
                    if !isSameUser() {
                        return
                    }
                    
                    DispatchQueue.main.async {
                        if !isSameUser() {
                            self?.photoImageView?.image = image
                        }
                    }
                }
        }
    }
}
