//
//  SocialServiceTask.swift
//  FriendsInFaceBook
//
//  Created by Viktoria on 1/29/18.
//  Copyright © 2018 Victoria Kravets. All rights reserved.
//

import Foundation
import PromiseKit

public class ServiceTask: Cancellable {
    
    // MARK: -
    // MARK: Properties
    
    public private(set) var isCancelled: Bool = false
    let request: FacebookApi
    
    // MARK: -
    // MARK: Init and Deinit
    
    public init(request: FacebookApi) {
        self.request = request
    }
    
    // MARK: -
    // MARK: Public
    
    public func cancel() {
        self.isCancelled = true
        self.request.facebookRequest?.cancel()
    }
}

