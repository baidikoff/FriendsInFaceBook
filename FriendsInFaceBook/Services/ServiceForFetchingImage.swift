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
    
    let defaultSession = URLSession(configuration: .ephemeral)
    var dataTask: URLSessionDataTask?
    // MARK: -
    // MARK: Open
    
    open func fetchImage(url: URL, complection: @escaping (UIImage?) -> ()){
        dataTask = defaultSession.dataTask(with: url, completionHandler: { data, response, error in
            error.do{print("URLSession error: ", $0); return}
            DispatchQueue.main.async {
                let image = data.flatMap(UIImage.init(data:))
                complection(image)
            }
        })
        dataTask?.resume()
    }
}
