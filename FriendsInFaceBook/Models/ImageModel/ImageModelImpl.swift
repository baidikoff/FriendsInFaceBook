//
//  ImageModelImpl.swift
//  FriendsInFaceBook
//
//  Created by Oleksa 'trimm' Korin on 12/20/17.
//  Copyright © 2017 Victoria Kravets. All rights reserved.
//

import Foundation
import UIKit

public class ImageModelImpl: ImageModel {
    
    // MARK: -
    // MARK: Properties
    
    public let url: URL
    public private(set) weak var image: UIImage?
    public let imageLoadService: ImageLoadService
    
    public var isLoaded: Bool {
        return self.image != nil
    }
    
    private let lock = NSRecursiveLock()
    private var isLoading = false
    private var cancellable: Cancellable = LoadedImageModelTask()
    
    // MARK: -
    // MARK: Init and Deinit
    
    public init(url: URL, imageLoadService: ImageLoadService) {
        self.url = url
        self.imageLoadService = imageLoadService
    }
    
    // MARK: -
    // MARK: Public
    
    public func load(completion: @escaping (UIImage?) -> ()) -> Cancellable {
        return self.lock.do {
            if self.isLoaded {
                completion(self.image)
                
                return LoadedImageModelTask()
            }
            
            if self.isLoading {
                return self.cancellable
            } else {
                let cancellable = self.imageLoadService.fetchImage(url: self.url) { [weak self] image in
                    self?.isLoading = false
                    self?.image = image
                    completion(image)
                }
                
                self.cancellable = cancellable
                
                return cancellable
            }
        }
    }
}

