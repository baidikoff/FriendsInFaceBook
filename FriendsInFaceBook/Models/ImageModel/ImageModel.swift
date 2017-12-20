//
//  ImageModel.swift
//  FriendsInFaceBook
//
//  Created by Oleksa 'trimm' Korin on 12/20/17.
//  Copyright © 2017 Victoria Kravets. All rights reserved.
//

import Foundation
import UIKit

public protocol ImageModel {
    
    var url: URL { get }
    var image: UIImage? { get }
    
    func load(completion: @escaping (UIImage?) -> ()) -> Cancellable
}

public func ==(lhs: ImageModel, rhs: ImageModel) -> Bool {
    return lhs.url == rhs.url
}
