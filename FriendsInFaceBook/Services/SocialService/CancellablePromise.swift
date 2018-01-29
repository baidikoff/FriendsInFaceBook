//
//  SocialServiceTask.swift
//  FriendsInFaceBook
//
//  Created by Viktoria on 1/29/18.
//  Copyright © 2018 Victoria Kravets. All rights reserved.
//

import Foundation
import PromiseKit

public class CancellablePromise: Cancellable {
    
    // MARK: -
    // MARK: Properties
    
    public private(set) var isCancelled: Bool = false
    let promise: Promise<[User]>
    let request: FacebookApi
    
    // MARK: -
    // MARK: Init and Deinit
    
    public init(promise: Promise<[User]>, request: FacebookApi) {
        self.promise = promise
        self.request = request
    }
    
    // MARK: -
    // MARK: Public
    
    public func cancel() {
        self.isCancelled = true
        self.request.facebookRequest?.cancel()
    }
    
    public func returnPromise() -> Promise<[User]> {
        return self.promise
    } 
}

