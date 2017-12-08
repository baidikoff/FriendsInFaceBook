//
//  ServiceForFetchingImage.swift
//  FriendsInFaceBook
//
//  Created by Viktoria on 12/8/17.
//  Copyright © 2017 Victoria Kravets. All rights reserved.
//

import Foundation
import UIKit

class ServiceForFetchingImage{
    
    // MARK: -
    // MARK: Open
    
    open func fetchImage(url: URL) -> UIImage?{
        let image = NSData(contentsOf: url)
                .flatMap(cast)
                .flatMap(UIImage.init(data:))
         return image
    }
}
