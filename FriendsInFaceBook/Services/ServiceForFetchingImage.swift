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
    
    open func fetchImage(url: URL, complection: @escaping (UIImage?) -> ()){
        URLSession.shared.dataTask(with: url, completionHandler: { data, response, error in
            error.do{ error in print("URLSession error: ", error); return}
            DispatchQueue.main.async {
                let image = data.flatMap(UIImage.init(data:))
               complection(image)
            }
        }).resume()
    }
}
