//
//  SocialService.swift
//  FriendsInFaceBook
//
//  Created by Viktoria on 12/4/17.
//  Copyright © 2017 Victoria Kravets. All rights reserved.
//

import Foundation
import PromiseKit

protocol SocialService {
    func requestUsers() -> Promise<[User]>

}
