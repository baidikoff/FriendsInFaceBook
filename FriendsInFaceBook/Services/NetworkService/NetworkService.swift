//
//  NetworkService.swift
//  FriendsInFaceBook
//
//  Created by Oleksa 'trimm' Korin on 12/14/17.
//  Copyright © 2017 Victoria Kravets. All rights reserved.
//

import Foundation

public enum NetworkServiceError: Error {
    case unknown
    case failed
}

public protocol NetworkService {
    func data(at url: URL, completion: @escaping (Result<Data, NetworkServiceError>) -> ()) -> NetworkTask
}
