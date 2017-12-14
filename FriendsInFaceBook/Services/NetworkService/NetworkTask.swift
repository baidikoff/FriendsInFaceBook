//
//  NetworkTask.swift
//  FriendsInFaceBook
//
//  Created by Oleksa 'trimm' Korin on 12/14/17.
//  Copyright © 2017 Victoria Kravets. All rights reserved.
//

import Foundation

public class NetworkTask: Cancellable {
    
    // MARK: -
    // MARK: Properties
    
    public private(set) var isCancelled: Bool = false
    
    private let urlSessionTask: URLSessionTask
    
    // MARK: -
    // MARK: Init and Deinit
    
    public init(urlSessionTask: URLSessionTask) {
        self.urlSessionTask = urlSessionTask
    }
    
    // MARK: -
    // MARK: Public
    
    public func cancel() {
        self.urlSessionTask.cancel()
        self.isCancelled = true
    }
}
