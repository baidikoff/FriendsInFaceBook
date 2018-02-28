//
//  ImageDownloadServiceImpl.swift
//  FriendsInFaceBook
//
//  Created by Viktoria on 12/8/17.
//  Copyright © 2017 Victoria Kravets. All rights reserved.
//

import Foundation
import UIKit

class ImageDownloadServiceImpl: ImageLoadService {
    
    // MARK: -
    // MARK: Properties
    
    public let networkService: NetworkService

    // MARK: -
    // MARK: Init and Deinit
    
    public init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    // MARK: -
    // MARK: Open
    
    open func fetchImage(url: URL, completion: @escaping (UIImage?) -> ()) -> Cancellable {
        return self.networkService.data(at: url) { result in
            completion § result.map(UIImage.init).value.flatten()
        }
    }
}
